# Grub

Grub is the bootloader.
System firmware reads a boot loader from the disk and then
passes the controller to the bootloader e.g. GRUB

RHEL has bootloader located at /boot/efi/EFI/redhat/grubx64.efi
which contains signature for a Secure Boot System.

In archlinux we simple run the grub-install,which install grubx64.efi at the mentioned directory
Grub reads its UEFI configuration from /boot/efi/EFI/redhat/grub.cfg

But do not edit grub.cfg directly, instead edit file located in <br>
/etc/default/grub or file under /etc/grub.d/ and then run command

grub2-mkconfig --output=/boot/efi/EFI/redhat/grub.cfg

initramfs is an archive with the kernel modules for all the required hardware at boot, initialization scripts.
initramfs is present in /boot directory.

The boot loader handles control over to the kernel and passes specific option 
mentioned in the kernel command line in the boot loader.


```shell
ls -ln /usr/sbin/init 
lrwxrwxrwx 1 0 0 22 Sep 24 11:18 /usr/sbin/init -> ../lib/systemd/systemd*
```
