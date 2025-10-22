# Learnings from installing ArchLinux

## Verify the signature on the ISO

```shell
➤ gpg --verify archlinux-2025.09.01-x86_64.iso.sig archlinux-2025.09.01-x86_64.iso
gpg: Signature made Mon 01 Sep 2025 06:39:15 PM CEST
gpg:                using EDDSA key 3E80CA1A8B89F69CBA57D98A76A5EF9054449A5C
gpg:                issuer "pierre@archlinux.org"
gpg: Can't check signature: No public key
```

### Download and import this key in our key ring

```shell
gpg --auto-key-locate clear,wkd -v --locate-external-key pierre@archlinux.org

# clear - it will ignore configurations inside gnu conf file, # default option
# wkd - search using web key directory (wkd) protocol, # default option
# locate-external-key must be followed by the id of the keyq
# NOTE
      # GnuPG's automatic key retrieval is controlled with the 
      # --auto-key-locate option which defaults to local,wkd.
      # In case you have set auto-key-locate to a value without
      # wkd in the GPG configuration file, you can use the --auto-key-locate 
      # clear,wkd command line option to override it.

➤ gpg --auto-key-locate clear,wkd --locate-external-key pierre@archlinux.org

gpg: key 76A5EF9054449A5C: public key "Pierre Schmitz <pierre@archlinux.org>" imported
gpg: key 7F2D434B9741E8AC: public key "Pierre Schmitz <pierre@archlinux.org>" imported
gpg: key 76A5EF9054449A5C: "Pierre Schmitz <pierre@archlinux.org>" not changed
gpg: key 7F2D434B9741E8AC: "Pierre Schmitz <pierre@archlinux.org>" not changed
gpg: Total number processed: 4
gpg:               imported: 2
gpg:              unchanged: 2
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
pub   ed25519 2022-10-31 [SC] [expires: 2037-10-27]
      3E80CA1A8B89F69CBA57D98A76A5EF9054449A5C
uid           [ unknown] Pierre Schmitz <pierre@archlinux.org>
sub   ed25519 2022-10-31 [A] [expires: 2037-10-27]
sub   cv25519 2022-10-31 [E] [expires: 2037-10-27]

# verify the signature
➤ gpg --verify archlinux-2025.09.01-x86_64.iso.sig archlinux-2025.09.01-x86_64.iso
gpg: Signature made Mon 01 Sep 2025 06:39:15 PM CEST
gpg:                using EDDSA key 3E80CA1A8B89F69CBA57D98A76A5EF9054449A5C
gpg:                issuer "pierre@archlinux.org"
gpg: Good signature from "Pierre Schmitz <pierre@archlinux.org>" [unknown]
gpg: WARNING: The keys User ID is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 3E80 CA1A 8B89 F69C BA57  D98A 76A5 EF90 5444 9A5C

# If you wish to get rid of the warning message above, you must trust the key.
# To do this

gpg --edit-key pierre@archlinux.org
# then type trust
# select the level of trust. I selected 5 which is
# I trust ultimately

# now, run the verification again.

➤ gpg --verify archlinux-2025.09.01-x86_64.iso.sig archlinux-2025.09.01-x86_64.iso
gpg: Signature made Mon 01 Sep 2025 06:39:15 PM CEST
gpg:                using EDDSA key 3E80CA1A8B89F69CBA57D98A76A5EF9054449A5C
gpg:                issuer "pierre@archlinux.org"
gpg: checking the trustdb
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   2  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 2u
gpg: next trustdb check due at 2037-10-27
gpg: Good signature from "Pierre Schmitz <pierre@archlinux.org>" [ultimate]

```
## Verify sha256sums

```shell

# download the sha256sums
wget https://archlinux.org/iso/2025.09.01/sha256sums.txt


➤ cat -n sha256sums.txt
     1	961002fab836819b599e770aa25ff02bff1697d1d051140062066a5ff47d6712  archlinux-2025.09.01-x86_64.iso
     2	961002fab836819b599e770aa25ff02bff1697d1d051140062066a5ff47d6712  archlinux-x86_64.iso
     3	29663e9fa235db2a91fd54d600b5be606160d1703b1956b3c19ed28322c17738  archlinux-bootstrap-2025.09.01-x86_64.tar.zst
     4	29663e9fa235db2a91fd54d600b5be606160d1703b1956b3c19ed28322c17738  archlinux-bootstrap-x86_64.tar.zst
# I wish to delete line 2 till 4

➤ sed '2,4 d' sha256sums.txt
961002fab836819b599e770aa25ff02bff1697d1d051140062066a5ff47d6712  archlinux-2025.09.01-x86_64.is

# lets do checksum
➤ cat $(echo sha256sums.txt) | sha256sum --check 
archlinux-2025.09.01-x86_64.iso: OK # <-- This is important
```

## Make a boot USB Stick

First step is to insert the stick. Once you insert you can tail 

```shell
➤ sudo dmesg | tail
[ 4582.056187] sd 0:0:0:0: [sda] 245760000 512-byte logical blocks: (126 GB/117 GiB)
[ 4582.056326] sd 0:0:0:0: [sda] Write Protect is off
[ 4582.056330] sd 0:0:0:0: [sda] Mode Sense: 03 00 00 00
[ 4582.056463] sd 0:0:0:0: [sda] No Caching mode page found
[ 4582.056466] sd 0:0:0:0: [sda] Assuming drive cache: write through
[ 4582.104057]  sda: sda1 sda2 sda3 sda4
[ 4582.104209] sd 0:0:0:0: [sda] Attached SCSI removable disk
[ 4582.457510] ISO 9660 Extensions: Microsoft Joliet Level 3
[ 4582.460992] ISO 9660 Extensions: Microsoft Joliet Level 3
[ 4582.508214] ISO 9660 Extensions: RRIP_1991A
```

### But there is another cool method, learnt via ArchLinux documentation


```shell

ls -l /dev/disk/by-id/usb-*
lrwxrwxrwx. 1 root root  9 Sep 14 10:12 /dev/disk/by-id/usb-VendorC_ProductCode_FC5118F654773-0:0 -> ../../sda
lrwxrwxrwx. 1 root root 10 Sep 14 10:12 /dev/disk/by-id/usb-VendorC_ProductCode_FC5118F654773-0:0-part1 -> ../../sda1
lrwxrwxrwx. 1 root root 10 Sep 14 10:12 /dev/disk/by-id/usb-VendorC_ProductCode_FC5118F654773-0:0-part2 -> ../../sda2
lrwxrwxrwx. 1 root root 10 Sep 14 10:12 /dev/disk/by-id/usb-VendorC_ProductCode_FC5118F654773-0:0-part3 -> ../../sda3
lrwxrwxrwx. 1 root root 10 Sep 14 10:12 /dev/disk/by-id/usb-VendorC_ProductCode_FC5118F654773-0:0-part4 -> ../../sda4

```

### Make a bootable iso

As per the documentation, there are many ways you can create a boot ISO. But I'm using a standard one

```shell
dd bs=4M if=archlinux-2025.09.01-x86_64.iso \
of=/dev/disk/by-id/usb-VendorC_ProductCode_FC5118F654773-0:0 \
conv=fsync oflag=direct status=progress
```

#### Notes on dd

- dd is same as cp but it also convert data during the copy and it does<br>
  copy the bit-to-bit copy of the file with lower-level I/O flow control.
- dd by default outputs nothing until task has finish. This explains<br>
  why we have used status=progress.
- bs stands for block size. In above command <br>
  `bs=4M` suggests we are taking 4MB block of data at a time. <br>
  bigger value will improve performance but at the cost of Memory. <br>
  By default the size is 512 byte, but recommended value is 32M or 64M. <br>
  Unsure why we are using `4M` in above command.
- NB: conv and oflag is still unclear to me.

### Notes on UEFI

UEFI - Universal Extended Firmware Interface

To check if the system is booted using EFI, 

```shell
➤ tree -C -L 1 /sys/firmware/efi
/sys/firmware/efi
├── config_table
├── efivars
├── esrt
├── fw_platform_size
├── fw_vendor
├── mok-variables
├── runtime
├── runtime-map
└── systab

5 directories, 5 files
```

EFI requires an EFI System Partition (ESP), which is FAT32 partition.
This is first partition we create in install_steps.md using `-F32` flag.
It is typically mounted at /boot or /boot/efi. Here EFI binary is stored.

```shell
➤ lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
zram0       251:0    0     8G  0 disk [SWAP]
nvme0n1     259:0    0 476.9G  0 disk 
├─nvme0n1p1 259:1    0   600M  0 part /boot/efi
├─nvme0n1p2 259:2    0     1G  0 part /boot
└─nvme0n1p3 259:3    0 475.4G  0 part /home
                                      /
```