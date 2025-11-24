#!/bin/bash
subscription-manager register --username $SUB_USERNAME_VAR --password $SUB_PASSWORD_VAR
dnf update -y
dnf install fish git tree -y
timedatectl set-local-rtc 0
export USERID=zorro
export USERNAME="Mr.Zorro"
export USERPASSWD="BMW#2025"
useradd --comment $USERNAME --shell $(which fish) $USERID
echo $USERID:$USERPASSWD | chpasswd
passwd --expire $USERID
mkdir -pv /home/$USERID/.ssh
chmod -vR u=rwX /home/$USERID/.ssh
chmod -vR og-rwx /home/$USERID/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO5wL3QVIe+yi+0+ILK7LZBQMq7n+ez46mD7a75oL31p 2025-11-23" > /home/$USERID/.ssh/authorized_keys
chown -Rv $USERID:$USERID /home/$USERID/.ssh
echo "$USERID ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERID
chmod -v 0440 /etc/sudoers.d/$USERID
mount -o ro /tmp/VBoxGuestAdditions.iso /mnt
bash /mnt/VBoxLinuxAdditions.run
systemctl shutdown -r now