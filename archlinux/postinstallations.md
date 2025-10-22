# Post Installation Steps


## Change login keyboard

When you login, the default keyboard is set to US, <br> Since I have German keyboard, i have to change this. <br>Change to root using `su -` and run

```shell
localectl set-keymap de-latin1
```

## Configure sudo

Configure sudoers.d to allow the following without password

- pacman
- shutdown
- restart

```shell
# as root create vim /etc/sudoers.d/nameOftheUser
Defaults timestamp_timeout=60
repolevedp ALL=(ALL) ALL, NOPASSWD: /usr/sbin/reboot, /usr/sbin/shutdown, /usr/sbin/pacman
```

## Connect to wifi

```shell
nmcli device wifi connect <nameOftheSiD> --ask
```

## Change shell for the user

```shell
chsh -s $(which fish)
```

## Install fonts and browsers

Install fonts
- ttf-ubuntu-font-family
- ttf-cascadia-code
- ttf-opensans
- noto-fonts
- ttf-fira-mono
- ttf-fira-sans

```shell
pacman -S code firefox chromium ttf-cascadia-code ttf-opensans noto-fonts tf-fira-mono ttf-fira-sans
```

## Check/Verify

- timedatectl
    - set ntp to true
- check hostname

## Install pass

```shell
sudo pacman -S pass wl-clipboard yubikey-manager libfido2 hwinfo pam-u2f restic
sudo systemctl enable --now pcscd
```