# Installation steps

Boot from USB Stick. USB Stick was created in the last post.
Since this laptop and has WIFI, I'm going to focus on configuring wifi

## find the name of the wifi card
ip a 

## find the discoverable SSID

`iwctl station wlan0 get-networks`

## Connect to the wifi card

`iwctl station wlan connect ZFHS60`

enter paraphrase for your wifi

check if the ip was allocated

`ip a`

from here you can change the root password using
`passwd`, check ssh service is running

`systemctl status sshd`

and then ssh into the system via your remote machine


### Create partition table

```shell
# Following are the partition table created

Number  Start (sector)    End (sector)  Size       Code  Name
   1            2048         2099199   1024.0 MiB  EF00  EFI system partition
   2         2099200         4196351   1024.0 MiB  8300  Linux filesystem
   3         4196352       272631807   128.0 GiB   8200  Linux swap
   4       272631808      2000408575   823.9 GiB   8E00  Linux LVM

# remember the Code which are important while creating partition.
# I used gdisk

```

### Format Partitions

```shell
# Format partition 01 as FAT
mkfs.fat -F32 /dev/nvme0n1p1

# Format partition 02 as ext4
mkfs.ext4 /dev/nvme0n1p2

# Format partition 03 as swap Make swap partition
mkswap /dev/nvme0n1p3

# DO NOT FORMAT PARTITION 04, instead encrypt it
cryptsetup luksFormat /dev/nvme0n1p4

# Create LVs but before that OPEN/DECRYPT the partition
cryptsetup open --type=luks /dev/nvme0n1p4 lvm

# use MAPPER to create physical volume
pvcreate /dev/mapper/lvm

vgcreate vgroup0 /dev/mapper/lvm

# root
lvcreate  -L 30G vgroup0 -n lv_root

# home
lvcreate -L 500GB vgroup0 -n lv_home

# UPDATE LVs
modprobe dm_mod

# scan the volumes
vgscan

# activate volumes
vgchange -ay

# -a is all, y is to confirm



mkfs.ext4 /dev/mapper/vgroup0-lv_root 
mkfs.ext4 /dev/mapper/vgroup0-lv_home

mkswap /dev/nvme0n1p3
swapon -v /dev/nvme0n1p3
swapon -s 
```

### Mounting partition


```shell
# create directory
mkdir -pv /mnt/boot
mkdir -pv /mnt/home

# mount root
mount /dev/mapper/vgroup0-lv_root /mnt

# mount boot
mount /dev/nvme0n1p2 /mnt/boot

# mount home
mount /dev/mapper/vgroup0-lv_home /mnt/home

```

### Installing

pacstrap -i /mnt base

### generate fstab file

```shell
genfstab -U -p /mnt >> /mnt/etc/fstab && cat /mnt/etc/fstab

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

### Change root and start

arch-chroot /mnt

#### set root password

passwd for root

#### create a user
useradd -m -g users -G wheel repoleveldp
passwd repoleveldp



# timedatectl set-timezone Europe/Berlin
hwclock --systohc # Sync hardware clock with system time

# hostnamectl set-hostname darchl

### Package installations

pacman -S base-devel dosfstools grub efibootmgr lvm2 mtools vim networkmanager openssh os-prober sudo gnome gnome-tweaks

#### enable services

systemctl enable NetworkManager
systemctl enable sshd
systemctl enable gdm

#### install linux kernels
pacman -S linux linux-headers

#### install hardware specific firmwares

pacman -S linux-firmware

#### install nvidia specific drivers

pacman -S nvidia nvidia-settings nvidia-utils

### Boot configuration

edit file `/etc/mkinitcpio.conf` and ensure the line looks below

HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block encrypt lvm2 filesystems fsck)

esp we have to add `encrypt lvm2`

###

mkinitcpio -p linux


### change locale to English
vim /etc/locale.gen
locale-gen

vim /etc/locale.conf
LANG=en_US.UTF-8

German keyboard and console

/etc/vconsole.conf:

KEYMAP=de-latin1
FONT=eurlatgr

### Configure grub to boot from encrypted device

vim /etc/default/grub and change the line as shown below
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 cryptdevice=/dev/nvme0n1p4:vgroup0 quiet"

### mount EFI

mkdir -v /boot/EFI

mount /dev/nvme0n1p1 /boot/EFI/

### Create install and configure grub
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck

grub-mkconfig -o /boot/grub/grub.cfg