# Installing and customizing Gnome Terminal

I personally fill it is bit important to customize terminal to get a good feel at least on linux because it makes sense as we spent so much time there.

On RHEL you need to add repo as mentioned below

```bash
# version does not matter
cd /etc/yum.repos.d/
wget https://download.opensuse.org/repositories/shells:zsh-users:zsh-syntax-highlighting/RHEL_7/shells:zsh-users:zsh-syntax-highlighting.repo
yum install zsh-syntax-highlighting
```
## Change shell

chsh -s $(which zsh) $USER
rebooting is required after this command

## enable syntax high lighting
Second, enable zsh-syntax-highlighting by sourcing the script. Running this command on the terminal will add the source line to the end of your .zshrc:

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
# echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

source ./zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```
## install exa

sudo dnf install exa -y

## Install powerlevel10k

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/Downloads/powerlevel10k
echo 'source ~/Downloads/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
```


### Configure powerlevel10

p10k configure

## Reference
<https://dev.to/abdfnx/oh-my-zsh-powerlevel10k-cool-terminal-1no0>
