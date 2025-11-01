# How to install and signed virtualbox?

### First add Vagrant .repo file

```bash filename /etc/yum.repos.d/virtualbox.repo
cat <<EOF>> virtualbox.repo
[virtualbox]
name=VirtualBox
baseurl=http://download.virtualbox.org/virtualbox/rpm/el/\$releasever/\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.virtualbox.org/download/oracle_vbox_2016.asc
EOF
sudo chown -v root:root virtualbox.repo
sudo mv -v virtualbox.repo /etc/yum.repos.d/
sudo dnf update -y
```

### Second install vagrant, here is the .repo file

```bash filename /etc/yum.repo.d/vagrant.repo
cat <<EOF>>vagrant.repo
[vagrant]
name=vagrant
baseurl=https://rpm.releases.hashicorp.com/RHEL/\$releasever/\$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://rpm.releases.hashicorp.com/gpg
EOF
sudo chown -v root:root vagrant.repo
sudo mv -v vagrant.repo /etc/yum.repos.d/
sudo dnf update -y
```

or simple use the following command

```shell
wget -O- https://rpm.releases.hashicorp.com/fedora/hashicorp.repo | sudo tee /etc/yum.repos.d/hashicorp.repo
```

### Step: 03 install the right packages

```bash

sudo dnf install pesign openssl kernel-devel mokutil keyutils vagrant VirtualBox-7.1.x86_64 -y

# reference [sign modules](https://docs.redhat.com/de/documentation/red_hat_enterprise_linux/8/html/managing_monitoring_and_updating_the_kernel/signing-a-kernel-and-modules-for-secure-boot_managing-monitoring-and-updating-the-kernel#signing-a-kernel-and-modules-for-secure-boot_managing-monitoring-and-updating-the-kernel)

```

### create directory, private key for signing and mokutil

```bash
sudo mkdir -pv /root/signed-modules
openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -nodes -days 36500 -subj "/CN=vagrantbox/"

sudo chown -v root:root MOK.der MOK.priv
sudo mv -v MOK.der MOK.priv /root/signed-modules
sudo mokutil --import /root/signed-modules/MOK.der
# enter a simple password
```

### Step: 04 reboot the system

- During the boot when prompted choose Enroll MOK
- You will see the keys that were created and signed and choose Continue
- reboot


### step: 05 load the driver

```bash
sudo /sbin/vboxconfig
# this will fail but drivers will be loaded, and it is necessary step for the script to run successfully
```
        

### Step: 06 create a bash script

```bash
sudo /sbin/vboxconfig
cat <<EOF>>copy_Sign.sh
#!/bin/bash
for modfile in \$(dirname $(modinfo -n vboxdrv))/*.ko; do
        echo "\$modfile"
        /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 /root/signed-modules/MOK.priv /root/signed-modules/MOK.der \$modfile
done
EOF
# needs to run at every start up
sudo bash /root/copy_Sign.sh
sudo modprobe vboxdrv && sudo systemctl start vboxdrv && sudo systemctl is-active vboxdrv
sudo modprobe -r kvm_intel  # in case you kvm/crc running
```

### step: 07

#### sudo modprobe vboxdrv

#### sudo systemctl start vboxdrv

