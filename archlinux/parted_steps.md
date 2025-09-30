# Partitioning disk using parted

Here is step by step guide on partitioning disk using parted

## List partitions

```shell
root@archiso ~ # parted /dev/nvme0n1 print
Model: PC801 NVMe SK hynix 1TB (nvme)
Disk /dev/nvme0n1: 1024GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size    File system     Name                  Flags
 1      1049kB  1075MB  1074MB  fat32           EFI system partition  boot, esp
 2      1075MB  2149MB  1074MB  ext4            Linux filesystem
 3      2149MB  140GB   137GB   linux-swap(v1)  Linux swap            swap
 4      140GB   1024GB  885GB                   Linux LVM             lvm

``` 

## Remove partitions

Remove partitions if they exists

```shell
parted /dev/nvme0n1 rm 1
parted /dev/nvme0n1 rm 2
parted /dev/nvme0n1 rm 3
parted /dev/nvme0n1 rm 4
# --script flag does not prompt for intervention
```

## Create partitions
parted /dev/nvme0n1 --script mklabel gpt

parted /dev/nvme0n1 --script mkpart "EFISystemPartition" fat32 1MiB 1GiB
parted /dev/nvme0n1 --script mkpart "RootPartition" ext4 1GiB 2GiB
parted /dev/nvme0n1 --script mkpart "SwapPartition" linux-swap  2GiB 130GiB
parted /dev/nvme0n1 --script mkpart "HomePartition" ext4  130GiB 100%

### Check optionally if partitioned are aligned

parted /dev/nvme0n1 --script align-check opt 1
parted /dev/nvme0n1 --script align-check opt 2
parted /dev/nvme0n1 --script align-check opt 3
parted /dev/nvme0n1 --script align-check opt 4

or you can use a simple script

for i in {1..4}; do parted /dev/nvme0n1 --script align-check opt $i && echo $?; done

parted /dev/nvme0n1 print

parted /dev/nvme0n1 --script set 1 esp on (esp is an alias for boot on GPT)
parted /dev/nvme0n1 --script set 3 swap on 
parted /dev/nvme0n1 --script set 4 lvm on

parted /dev/nvme0n1 print

root@archiso ~ # parted /dev/nvme0n1 print
Model: PC801 NVMe SK hynix 1TB (nvme)
Disk /dev/nvme0n1: 1024GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size    File system  Name                Flags
 1      1049kB  1074MB  1073MB  fat32        EFISystemPartition  boot, esp
 2      1074MB  2147MB  1074MB               RootPartition       
 3      2147MB  140GB   137GB                SwapPartition       swap
 4      140GB   1024GB  885GB                HomePartition       lvm

