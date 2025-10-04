# Post Installation Steps

## Change login keyboard

login keyboard is set to US, since i have de keyboard, i have to change this

sudo localectl set-keymap de-latin1

## Configure wifi

nmcli device wifi connect <nameOftheSiD> --ask

## Change shell for the user

chsh -s $(which fish)

Install fonts
- ttf-ubuntu-font-family
- ttf-cascadia-code
- ttf-opensans
- noto-fonts
- ttf-fira-mono
- ttf-fira-sans

pacman -S code firefox chromium 

Install opensource vscode
Install firefox

check/Verify

- timedatectl
    - set ntp to true
- check hostname

configure sudoers.d to allow the following without password

- pacman
- shutdown
- restart


sudo pacman -S pass wl-clipboard yubikey-manager
sudo systemctl enable --now pcscd
