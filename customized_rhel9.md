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


