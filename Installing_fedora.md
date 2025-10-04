# Installing Fedora 42

## Check ISO

wget <download fedora.gpg>
gpgv --keyring ./fedora.gpg <NameOftheCheckSumFile>

e.g. gpgv is to Verify OpenPGP Signature

```bash
➤ gpgv --keyring ./fedora.gpg Fedora-Workstation-42-1.1-x86_64-CHECKSUM 
gpgv: Signature made Fri 11 Apr 2025 01:29:41 PM CEST
gpgv:                using RSA key B0F4950458F69E1150C6C5EDC8AC4916105EF944
gpgv: Good signature from "Fedora (42) <fedora-42-primary@fedoraproject.org>"
```


Create Partition

- efi partition

/boot/efi - 1GiB is enough

- parition for other volumes but this will be encrypted partition

- /
- /opt
- /home

All mount points below contains files which are temporary
## var
- /var/cache 
- /var/log
- /var/spool
- /var/lib/libvirt
- /var/tmp
- /var/lib/gdm

## How to change pbkdp

cryptsetup luksDump /dev/nvme0n1p2 | grep PBKDF

cryptsetup luksChangeKey /dev/nvme0n1p2 --pbkdf pbkdf2 --pbkdf-force-iterations 500000

Why LUKS2?


vi /mnt/sysroot/boot/efi/EFI/fedora/


