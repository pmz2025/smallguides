# Steps to customized RHEL

- First enable fractional scaling using the following command. Fractional Display Scaling is considered a work in progress, but you can enable it from the cli.
  gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
- create a .vimrc file using the following settings
```bash
autocmd FileType yaml setlocal ts=2 sts=2 tw=2 ai et cuc
set nu
```
- install vs code using the following link
```bash
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
```
- put alias to vs code to adjust for fractional scaling

code --enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto

add the following repo

- vs code
## epel
The steps are 

sudo subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm


- 1password

1password.repo file

### install gnome tweaks
sudo dnf info gnome-tweaks

# Change shell to zsh

sudo dnf install zsh

mkdir -pv $HOME/.local/share/fonts

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip -O $HOME/Downloads/firacode.zip

unzip $HOME/Downloads/firacode.zip -d $HOME/.local/share/fonts

fc-cache -f -v

change the font 'Monospace Text' - Firacode Nerd Font Mono Retina

### Change gnome terminal theme

git clone https://github.com/dracula/gnome-terminal
cd gnome-terminal
./install.sh
mv 
Add eval `dircolors /path/to/dircolorsdb` in your shell configuration file (.bashrc, .zshrc, etc...) to use new dircolors.

### syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

### Install Printer

lpadmin -p myhomeprinter -E -v ipp://nameorIP_Printer/ipp/print -m everywhere

p = name of the queue
E = Encryption
v = device url
m = model