
```shell
mkdir -p ~/.vim/colors
wget https://raw.githubusercontent.com/ayu-theme/ayu-vim/refs/heads/master/colors/ayu.vim -O ~/.vim/colors/ayu.vim
```

vim ~/.vim/vimrc

```shell
set number
set termguicolors
let ayucolor="mirage"
colorscheme ayu
```