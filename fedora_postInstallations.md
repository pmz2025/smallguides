# Post Installation steps for Fedora

```shell
set HOSTNAME yourLinuxHostName
hostnamectl set-hostname $HOSTNAME
```


## Install all softwares

```shell
sudo dnf install cascadia-mono-pl-fonts.noarch fish vim pass yubikey-manager hwinfo pam-u2f restic pamu2fcfg seahorse podman-compose
```

## CHAnge shell

chsh -s $(which fish)

## CHAnge font
## CHAnge fish prompt and theme

add fish variables

## ADD repo

To install code
 - sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

```shell
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
```


modify sudoers.d

sudo vim /etc/sudoers.d/nameOftheUser

```shell
Defaults timestamp_timeout=60
repolevedp ALL=(ALL) ALL, NOPASSWD: /usr/sbin/systemctl, /usr/sbin/dnf
```

## Enable yubikey based login

CREate u2f_mappings file inside /etc

```shell
# yubikey 1
pamu2fcfg > u2f_mappings
# backup yubikey
pamu2fcfg -n >> u2f_mappings
# copy file
sudo mv -v u2f_mappings /etc
```

configure sudo and gdm-password file which are present in /etc/pam.d

```shell
# add following line at the top of gdm-password to allow passwordless entry
auth    sufficient pam_u2f.so  authfile=/etc/u2f_mappings cue nouserok pinverification=1
```


```shell
# add the following line in case you wish to allow 2nd factor authentication
# But this line must be added after your primary authencation method e.g. password
# Primary authentication method(s) above this line.
auth required pam_u2f.so authfile=/etc/u2f_mappings cue
```


## create ssh config file

```shell
#  create config file

mkdir -pv $HOME/.ssh

touch $HOME/.ssh/config
# add the lines using the template
# below

Host <YourName>
    AddKeyToAgent yes
    IdentitiesOnly yes
    IdentityFile $HOME/.ssh/nameOfthePrivateKey
```




### Import ssh keys from the encrypted USB

clone github repos
install freedium
install linkdings
import gpgkeys
initialize pass

to do

- copy your public key in westernmedia and on github
