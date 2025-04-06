# How to Configure Git on new linux

I keep resetting my Linux desktop and I keep forgetting initial and basic git config

here is one that serves this purpose

## First Check
```bash
git config --list # global settings for smallguides git repo

user.name=Preetam Openshift
user.email=openshiftpreetam@gmail.com
core.editor=code
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
remote.origin.url=https://github.com/preetamubuntu/smallguides.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.main.remote=origin
branch.main.merge=refs/heads/main
branch.main.vscode-merge-base=origin/main
```
These settings are stored in ~/.gitconfig

```bash
└[~]> cat ~/.gitconfig 
[user]
	name = Preetam Openshift
	email = openshiftpreetam@gmail.com
[core]
	editor = code
┌[poseidon@delltb1542] [/dev/pts/0] 
└[~]> 

┌[poseidon@delltb1542] [/dev/pts/0] [1] # System Settings
└[~]> git config --list
user.name=Preetam Openshift
user.email=openshiftpreetam@gmail.com
core.editor=code

┌[poseidon@delltb1542] [/dev/pts/0] # Global Settings
└[~]> git config --list --global
user.name=Preetam Openshift
user.email=openshiftpreetam@gmail.com
core.editor=code
```
### Configure basic things for new setup

git config --global user.name myname
git config --global user.email myemail@email.com
git config --global core.editor code
git config --global core.pager 'less -R'


## Reference

[Configure Git like a Pro](https://medium.com/@kszpiczakowski/configure-git-like-a-pro-meet-git-3-e48f82b1c346)
