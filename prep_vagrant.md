# How to install and signed virtualbox?

### First install virtualbox. Here is the .repo file

```bash filename /etc/yum.repo.d/virutalbox.repo
[virtualbox]
name=VirtualBox
baseurl=http://download.virtualbox.org/virtualbox/rpm/el/$releasever/$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.virtualbox.org/download/oracle_vbox_2016.asc
```

### Second install vagrant, here is the .repo file

```bash filename /etc/yum.repo.d/vagrant.repo
[vagrant]
name=vagrant
baseurl=https://rpm.releases.hashicorp.com/RHEL/$releasever/$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://rpm.releases.hashicorp.com/gpg
```

### Step: 03 install the right packages

```bash

dnf install pesign openssl kernel-devel mokutil keyutils -y

# reference [sign modules](https://docs.redhat.com/de/documentation/red_hat_enterprise_linux/8/html/managing_monitoring_and_updating_the_kernel/signing-a-kernel-and-modules-for-secure-boot_managing-monitoring-and-updating-the-kernel#signing-a-kernel-and-modules-for-secure-boot_managing-monitoring-and-updating-the-kernel)

```

### create directory, private key for signing and mokutil

```bash
sudo -i
mkdir -pv /root/signed-modules

cd /root/signed-modules

openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -nodes -days 36500 -subj "/CN=vagrantbox/"
mokutil --import /root/module-signing/MOK.der
# enter a simple password
```

### Step: 04 reboot the system

- During the boot when prompted choose Enroll MOK
- You will see the keys that were created and signed and choose Continue
- reboot


### step: 05 load the driver

```bash
sudo -i
/sbin/vboxconfig
# this will fail but drivers will be loaded, and it is necessary step for the script to run successfully
```


### Step: 06 create a bash script

```bash
#!/bin/bash
for modfile in $(dirname $(modinfo -n vboxdrv))/*.ko; do
        echo "$modfile"
        /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 /root/signed-modules/MOK.priv /root/signed-modules/MOK.der $modfile
done
```

### step: 07 

modprobe vboxdrv
systemctl start vboxdrv
