# Filesysten Hierarchy

## Var

What i found most important inside this directory is

/var/cache/pacman/pkg


## /usr

all files inside the directory are owned by root <br>
and you have only r-x permission.

/usr/share contains documentation and icons

important folder is /usr/share/zoneinfo

## /sys

all files inside this directory represents kernel and system.
Important folder i came across here is

/sys/firmware/efi and cat /sys/firmware/efi/fw_platform_size to find if the system is 32 or 64 bit.

## /srv

I have personally never used this directory until now.
As per the document, it is used by web and ftp servers

## /sbin

Reserved for the root only. e.g. reboot and shutdown are here.
/usr/sbin is linked to /usr/bin

## /opt

The application/packages which are not default and they are optional
and third party software.

## /lib

This directory contains library and kernel modules necessary for running
binaries found in /bin and /sbin.