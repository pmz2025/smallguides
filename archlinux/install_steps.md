# Installation steps

Boot from USB Stick. USB Stick was created in the last post.
Since this laptop and has WIFI, I'm going to focus on configuring wifi

## Find the name of the wifi card
`ip a` 

## Find the discoverable SSID

`iwctl station wlan0 get-networks`

## Connect to the wifi

`iwctl station wlan connect ZFHS60`

enter paraphrase for your wifi<br>
check if the ip was allocated with `ip a`

From here, you can change the root password using <br>
`passwd`, and check ssh service is running

`systemctl status sshd`

and then ssh into the system via your remote machine.

> If you wish to work on this machine and it is non-english keyboard use

`loadkeys de-latin1`

## Optionally configure mirror using reflector

`reflector --country Germany --sort rate --latest 5 --save /etc/pacman.d/mirrorlist`

this step is considered optional because reflector updates the mirror <br>
list by choosing 20 most recently synchronized HTTPS mirrors <br>
and sorting them by download rate.

## Checks

check ntp is set to true by default.

`timedatectl status`

if not

`timedatectl set-ntp true`


### Create partition table

Root Partition holds entire filesystem and it is configured as 30GiB as LVM volume.<br>
ESP EFI System Partition is the partition which hold bootloader files and it is configured
as 512MiB. <br> There is additional partition dedicated for boot which is configured as 1GiB


```shell
# Following are the partition table created

Number  Start (sector)    End (sector)  Size       Code  Name
   1            2048         2099199   1024.0 MiB  EF00  EFI system partition
   2         2099200         4196351   1024.0 MiB  8300  Linux filesystem
   3         4196352       272631807   128.0 GiB   8200  Linux swap
   4       272631808      2000408575   823.9 GiB   8E00  Linux LVM

# remember the Code which are important while creating partition.
# I used gdisk and information on how to partition disk using
# parted is shown in parted_stepd.md

```

### Format Partitions

Lets assume

/dev/nvme0n1p1 --> ESP
/dev/nvme0n1p2 --> Boot
/dev/nvme0n1p3 --> Swap
/dev/nvme0n1p4 --> LVM (which in turn includes /home, /root)

```shell
# Format partition 01 as FAT, this is efi system partition (ESP)
mkfs.fat -F32 /dev/nvme0n1p1

# Format partition 02 as ext4, this is boot partition
mkfs.ext4 /dev/nvme0n1p2

# Format partition 03 as swap Make swap partition
mkswap /dev/nvme0n1p3

# DO NOT FORMAT PARTITION 04, instead encrypt it
cryptsetup luksFormat /dev/nvme0n1p4

# Create LVs but before that OPEN/DECRYPT the partition
cryptsetup open --type=luks /dev/nvme0n1p4 lvm

# Create physical volume
pvcreate /dev/mapper/lvm

# Create volume group

vgcreate vgroup0 /dev/mapper/lvm

# Create LV for root
lvcreate  -L 30G vgroup0 -n lv_root

# Create LV for home
lvcreate -L 500GB vgroup0 -n lv_home

# UPDATE LVs
modprobe dm_mod

# scan the volumes
vgscan

# activate volumes
vgchange -ay

# -a is all, y is to confirm


# Format LVs
mkfs.ext4 /dev/mapper/vgroup0-lv_root 
mkfs.ext4 /dev/mapper/vgroup0-lv_home

mkswap /dev/nvme0n1p3
swapon -v /dev/nvme0n1p3
swapon -s 
```

### Mounting partition


```shell

# mount root
mount -v /dev/mapper/vgroup0-lv_root /mnt

# mount home, --mkdir will automatically create dir
mount --mkdir -v /dev/mapper/vgroup0-lv_home /mnt/home

# mount boot
mount --mkdir -v /dev/nvme0n1p2 /mnt/boot

# mount EFI
mount --mkdir -v /dev/nvme0n1p1 /mnt/boot/EFI 

# use findmnt to check mountpoint

findmnt -R /mnt

```

### Lets start Installation

pacstrap -i /mnt base vim

-i flag means prompt for package confirmation <br> (when needed und 
run interactively)
-K (optionally, capital k) initialize an empty packman keyring in the target.

### generate fstab file

```shell
genfstab -U -p /mnt >> /mnt/etc/fstab && cat /mnt/etc/fstab

# -U flag means use UUID
# -p flag means exclude pseudo mounts (which is default behaviour, unsure why it is included)

# Static information about the filesystems.
# See fstab(5) for details.

# <file system> <dir> <type> <options> <dump> <pass>
# /dev/mapper/vgroup0-lv_root
# /dev/mapper/vgroup0-lv_root
UUID=91de600d-f184-440c-9e09-f6dadb8bbfc3	/         	ext4      	rw,relatime	0 1

# /dev/nvme0n1p2
UUID=886b3d07-4c5a-4be2-83d7-b82c020f3ed0	/boot     	ext4      	rw,relatime	0 2

# /dev/mapper/vgroup0-lv_home
UUID=3fdc3853-6c33-4b03-8cb4-5826d509288c	/home     	ext4      	rw,relatime	0 2

# /dev/nvme0n1p3
UUID=6b9673ca-a434-4699-b83f-147c120edb54	none      	swap      	defaults  	0 0

```

## Change root and start

To directly interact with the new systems environment, tools <br>
and configurations for the next steps as if you are booted into <br>
it, change root

`arch-chroot /mnt`

### Set root password

passwd for root

### Create a user
useradd -m -g users -G network,video,audio repolevedp
passwd repolevedp

### Set timezone, hostname and hosts file


```shell

# set timezone
ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime

# set hostname
echo "archd" > /etc/hostname

# set hosts
vim /etc/hosts

# enter the following content
127.0.0.1 localhost
::1 localhost
127.0.1.1 archd.localdomain archd
```

### Package installationscales

```shell
pacman -S base base-devel linux linux-headers linux-firmware \
intel-ucode dosfstools grub efibootmgr lvm2 mtools vim \
networkmanager openssh os-prober sudo gnome gnome-tweaks \
man git tree fish nvidia nvidia-settings nvidia-utils \
mesa vulkan-intel
```

#### Enable services

systemctl enable NetworkManager sshd gdm bluetooth

### Configure Boot for the encrypted volume

edit file `/etc/mkinitcpio.conf` and ensure the line looks below

`HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block encrypt lvm2 filesystems fsck)`

esp we have to add `encrypt lvm2`

`mkinitcpio -p linux`


### Change locale to English
vim `/etc/locale.gen`
and search and uncomment line starting <br>
with `#en_US.UTF-8 UTF-8` and execute

`locale-gen`

### Configure grub to boot from encrypted device

vim /etc/default/grub and change the line as shown below
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 cryptdevice=/dev/nvme0n1p4:vgroup0 quiet"

### Create Grub configuration

`mount --mkdir /dev/nvme0n1p1 /boot/EFI`

### Create install and configure grub

```shell
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck

# grub_efi will be created under ESP directory which is /boot/EFI

# grub-install --target=x86_64-efi --efi-directory=esp --bootloader-id=GRUB

grub-mkconfig -o /boot/grub/grub.cfg
```

#### Flags

--efi-directory and --bootloader-id are specific to GRUB UEFI <br>
--efi-directory --> use DIR as the EFI System Partition root <br>
--bootloader-id=ID --> the ID of bootloader. This option is only available on EFI and Macs.

### Final Steps

```shell
# chroot exiting, type
exit

# Unmount all mountPoints under /mnt 
umount -R /mnt

# - flag R stands for recursive

reboot
```

Now follow postinstallations.md