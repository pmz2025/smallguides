# list all block devices

lsblk -pd

## Examine partitions for specific device

lsblk -pf /dev/nvme0n1

What is key derivation function?
LUKS2 by default uses Argon2id which is not compatible with GRUB,
and LUKS1 uses PBKDF2 as key derivative function. Hence we must change
the key derivative function as PBKDF2


