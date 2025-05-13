# Learning Fish

## Add path to the fish shell

fish_add_path $HOME/local/bin (This directory must exist)
fish_add_path -a $HOME/.crc/bin/oc

### Check themes
fish_config theme show

### Enable Auto completion
It is enabled by default

### Set variables
set -x MyVariable SomeValue

### Have similar functions as .bashrc file

simply edit .config/fish/config.fish file add the entries of your choice

set -x LESS "-X"


## Reference

[Great reference to start with](https://fishshell.com/docs/current/tutorial.html)
