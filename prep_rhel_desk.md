# Prepare RHEL Desktop

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