# Learning Fish

## Add path to the fish shell

fish_add_path $HOME/local/bin (This directory must exist)
fish_add_path -a $HOME/.crc/bin/oc

### Check themes

fish_config theme show

### Enable Auto completion

It is enabled by default, you can disable it using

set -g fish_autosuggestion_enabled 0


### Set variables

set -x MyVariable SomeValue

### Have similar functions as .bashrc file

simply edit .config/fish/config.fish file add the entries of your choice

set -x LESS "-X"

### Shortcuts or alias or Abbr

```shell
# create a dedicate file 
vim ~/.config/fish/conf.d/myabbrs.fish

# add your content
abbr --add ockadm 'oc login -u kubeadmin -p BnXhT-ychem-Ry5Iz-GYDXj https://api.crc.testing:6443'
abbr --add ocdev 'oc login -u developer -p developer https://api.crc.testing:6443'
```

## Reference

[Great reference to start with](https://fishshell.com/docs/current/tutorial.html)
