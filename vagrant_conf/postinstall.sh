#!/bin/bash
export USERID=peter
export USERNAME="Mr.Peter"
export USERPASSWD="VMware2025"
dnf update -y
dnf install fish git tree -y
useradd --comment $USERNAME --shell $(which fish) $USERID
echo $USERID:$USERPASSWD | chpasswd
passwd --expire $USERID
mkdir -pv /home/$USERID/.ssh
chmod -vR u=rwX /home/$USERID/.ssh
chmod -vR og-rwx /home/$USERID/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMJ2LKMyBUhLACMAiuMdBShSJidchM+LLzw45G3jL/Td SyslogClient02 created on 2025-11-01" > /home/$USERID/.ssh/authorized_keys
chown $USERID:$USERID /home/$USERID/.ssh

#mkdir -pv /home/$USERID/.vim/colors
mount -o ro /tmp/VBoxGuestAdditions.iso /mnt
bash /mnt/VBoxLinuxAdditions.run




