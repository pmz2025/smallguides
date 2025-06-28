# Configure Kitty

Install kitty

sudo dnf install kitty -y

Configuring Kitty is so simple.
kitty + kitten themes

kitty + list-fonts

## kitty + kitten + SSH

you should do ssh in the following
satorni is my openshift server

`kitty + kitten ssh satorni`

You can change the font size using ctrl + shift + F2
and then you can reload the configuration using ctrl + shift +F5


## Clear screen but retain history

edit the kitty config file with the following line

`map ctrl+l clear_terminal scroll active`

to split screen, press control+shift+enter

## Reference

[Kitty Config](https://manpages.ubuntu.com/manpages/jammy/man5/kitty.conf.5.html)

[Action-clear_terminal](https://sw.kovidgoyal.net/kitty/actions/#action-clear_terminal)
