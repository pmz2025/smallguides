# Encrypting USB Drive

Rules I used to document

First all Headings and line beginning starts with first 3 letters as capital
I have separated output of the command under OUTput esp <br> 
when the command is creating something, but not when command <br>
is reading or query e.g. `lsblk`

Here is the guide to encrypt USB drive but this is thumb <br>
drive not an external drive. A kind of portable to carry data upto 100 GiB <br>

This drive will have keeepass database, ssh keys and other important information.


## How to encrypt USB drive?

Before you start, this is tested on Archlinux and I'm sure this will work <br>
also on Fedora.

You need Yubikey, USB Drive and packages mentioned below

```shell
sudo pacman -S pass wl-clipboard yubikey-manager libfido2
sudo systemctl enable --now pcscd
```

### Partition and Format USB drive

Check where is USB mounted using 

```shell
╰─>$ lsblk
NAME                  MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
sda                     8:0    1 117.2G  0 disk  
└─sda1                  8:1    1 117.2G  0 part  # <-- USB Drive
nvme0n1               259:0    0 953.9G  0 disk  
├─nvme0n1p1           259:1    0  1023M  0 part  /boot/EFI
├─nvme0n1p2           259:2    0     1G  0 part  /boot
└─nvme0n1p3           259:3    0 951.9G  0 part  
  └─vgroup0           253:0    0 951.9G  0 crypt 
    ├─vgroup0-lv_root 253:1    0    30G  0 lvm   /
    └─vgroup0-lv_home 253:2    0   500G  0 lvm   /home

# or using another command mentioned below

╰─>$ ls -ls /dev/disk/by-id/ | grep -i usb 
0 lrwxrwxrwx 1 root root 10 Oct  5 11:15 dm-name-myusb -> ../../dm-3
0 lrwxrwxrwx 1 root root 10 Oct  5 11:15 dm-uuid-CRYPT-LUKS2-65696be72de94341a12bb2e95dc61203-myusb -> ../../dm-3
0 lrwxrwxrwx 1 root root  9 Oct  5 11:01 usb-VendorC_ProductCode_FC5118F654773-0:0 -> ../../sda
0 lrwxrwxrwx 1 root root 10 Oct  5 11:01 usb-VendorC_ProductCode_FC5118F654773-0:0-part1 -> ../../sda1

```

```shell
# CHeck if there are any data or partition
╰─>$ sudo parted /dev/sda print
```
**_OUTput_**
```v 
Model: VendorC ProductCode (scsi)
Disk /dev/sda: 126GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags: 

Number  Start  End  Size  File system  Name  Flags
```

```shell
# REMove the partition e.g. rm 1 removes partition 1
sudo parted /dev/sda1 --script rm 1 

# CREate label e.g. GPT
sudo parted /dev/sda1 --script mklabel gpt
```

# CREate Partition. 

I have a USB with 128 GB Size, I will create single partition

```shell
╰─>$ sudo parted /dev/sda mkpart "EncryptedPartition" 1MiB 100%
Information: You may need to update /etc/fstab.

# CHeck partition

╰─>$ sudo parted /dev/sda print
#-------------------------------------------->>
Model: VendorC ProductCode (scsi)
Disk /dev/sda: 126GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags: 

Number  Start   End    Size   File system  Name                Flags
 1      1049kB  126GB  126GB               EncryptedPartition
```

## 1. Encrypt Partition

We normally encrypt partition and then format the drive

```shell

╰─>$ sudo cryptsetup luksFormat --type luks2 /dev/sda1
#-------------------------------------------->>

WARNING: Device /dev/sda1 already contains a 'crypto_LUKS' superblock signature.

WARNING!
========
This will overwrite data on /dev/sda1 irrevocably.

Are you sure? (Type 'yes' in capital letters): YES
Enter passphrase for /dev/sda1: 
Verify passphrase: 
```

### 2. Format Partition

We need to open the encrypted partition, when you open <br>
encrypted partition, we must use name e.g. myEncUSB (as mentioned below)<br>
and then use this name to format the drive

```shell

╰─>$ sudo cryptsetup open --type=luks2 /dev/sda1 myEncUSB
Enter passphrase for /dev/sda1: 

# CHEck the if the device is mounted.

╰─>$ lsblk -pf /dev/sda1
#-------------------------------------------->>
NAME                   FSTYPE      FSVER LABEL UUID                                 FSAVAIL FSUSE% MOUNTPOINTS
/dev/sda1              crypto_LUKS 2           ef4d3a68-3e73-46ff-a2ae-27c3bd264c67                
└─/dev/mapper/myEncUSB            

```

### 3. FORmat with ext4

```shell
╰─>$ sudo mkfs.ext4 -v /dev/mapper/myEncUSB
```

**_OUTput_**

```v
mke2fs 1.47.3 (8-Jul-2025)
fs_types for mke2fs.conf resolution: 'ext4'
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
7684096 inodes, 30715392 blocks
1535769 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=2178940928
938 block groups
32768 blocks per group, 32768 fragments per group
8192 inodes per group
Filesystem UUID: a15a0fed-0923-49d4-82b1-5d23be08c965
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208, 
	4096000, 7962624, 11239424, 20480000, 23887872

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (131072 blocks): done
Writing superblocks and filesystem accounting information: done
```

At this stage USB drive is encrypted and formatted.
Right now you can decrypt (cryptsetup open) the usb <br>
mount the drive and start using it. But everytime, you must
enter paraphrase.

## How to enroll encrypted USB drive with Yubikey?

In this section, we are simply taking the paraphrase <br>
putting it in yubikey and then using yubikey's FIDO pin <br>
to open the drive. This is achieved using systemd-cryptenroll.

### Systemd-cryptenroll

Devices like Yubikey,TPM, smartcard can be enrolled using <br>
`systemd-cryptenroll` into LUKS encrypted volumes.

#### WHAt is keyslots


Below we are checking what slots are registered on LUKS formatted device.

╰─>$ sudo systemd-cryptenroll /dev/sda1 
SLOT TYPE    
   0 password



```shell

sudo systemd-cryptenroll /dev/sda1 --fido2-device list
PATH         MANUFACTURER PRODUCT               COMPATIBLE RK CLIENTPIN UP UV
/dev/hidraw6 Yubico       YubiKey OTP+FIDO+CCID ✓          ✓  ✓         ✓  ✗

Legend: RK        → Resident key
        CLIENTPIN → PIN request
        UP        → User presence
        UV        → User verification
#### -- #### --#### -- #### --#### -- #### --#### -- ####


╰─>$ sudo systemd-cryptenroll /dev/sda1 --fido2-device auto --fido2-with-user-verification yes
[sudo] password for repolevedp: 
🔐 Please enter current passphrase for disk /dev/sda1: ••••••••••••            
Locking with user verification test requested, but FIDO2 device /dev/hidraw1 does not support it, disabling.
Initializing FIDO2 credential on security token.
👆 (Hint: This might require confirmation of user presence on security token.)
🔐 Please enter security token PIN: •••••••••••••••••       
Generating secret key on FIDO2 security token.
👆 In order to allow secret key generation, please confirm presence on security token.
New FIDO2 token enrolled as key slot 1.


```

## ON Demand mounting of encrypted device

Now that USB is encrypted and secret key is created and stored on yubikey,
we have two options to mount the USB drive. One is permanent, this I'm not discussing <br>,
other is on demand. To reliably mount USB drive, we need it unique ID.
This you can find using

udevadm info -q symlink -r /dev/sda1

### What is udevadm

It is udev management tool.

- flag -q stands for query type. Query Type can be name, symlink, path, property or all.
- flag -r stands for root which prints absolute paths in name or symlink query.

```shell
╰─>$ udevadm info --query symlink -r /dev/sda1
```

**_OUTput_**

```v
/dev/disk/by-path/pci-0000:00:14.0-usb-0:8:1.0-scsi-0:0:0:0-part1 /dev/disk/by-partuuid/ed7f3cc0-40d6-4943-a357-58e69d00652b /dev/disk/by-uuid/5e756634-6469-4361-94eb-2ab0db3a11c3 /dev/disk/by-partlabel/EncryptedPartition
```

Pickup text starting with by-id and Attach drive using the following command


```shell
sudo systemd-cryptsetup attach MyEncUSB /dev/disk/by-path/pci-0000:00:14.0-usbv2-0:8:1.0-scsi-0:0:0:0-part1 none fido2-device=auto
🔐 Please enter LUKS2 token PIN: ••••••••••••••••••••••••••••••••••       
Asking FIDO2 token for authentication.
👆 Please confirm presence on security token to unlock.

# Detach the drive
sudo systemd-cryptsetup detach MyEncUSB
```

### WHAt is systemd-cryptsetup
This command is responsible for attaching and detaching encrypted devices.<br>
During the boot systemd-cryptsetup@.service is called.


