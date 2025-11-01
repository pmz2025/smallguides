# configure dracula thema on vim

mkdir -pv $HOME/.vim/pack/themes/start
cd $HOME/.vim/pack/themes/start
git clone https://github.com/dracula/vim.git dracula
vim $HOME/vim

echo "if v:version < 802 packadd! dracula endif syntax enable colorscheme dracula" > $HOME/vim/.vimrc