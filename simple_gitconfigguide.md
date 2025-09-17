# How to Configure Git on new linux

I keep resetting my Linux desktop and I keep forgetting initial and basic git config

## Difference between Global and system settings and Project

System settings applies to all user and can be overridden by global settings.

Global settings applies at user level.

Project settings are inside your git repo e.g. shown below.

And these are the lowest level of settings

```shell

cat ~/Documents/smallguides/.git/config 
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[remote "origin"]
	url = github_public:pmz2025/smallguides.git
	fetch = +refs/heads/*:refs/remotes/origin/*
[branch "main"]
	remote = origin
	merge = refs/heads/main
	vscode-merge-base = origin/main

# other way to check this is that you
# cd into git repo and type the following command

cd ~/Documents/smallguides/.git$ 
git config --list --local
######################## OutPut ####################################
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
remote.origin.url=github_public:pmz2025/smallguides.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.main.remote=origin
branch.main.merge=refs/heads/main
branch.main.vscode-merge-base=origin/main
######################## OutPut ####################################
``` 

### Check the system settings

```shell
git config --list --system
# fatal: unable to read config file '/etc/gitconfig': No such file or directory
```
#### Set a property at system level

```shell
git config --system core.editor=vim # just remember to use --system
```


### Check global settings

```shell
sapbmw@dellidali:~$ git config --list --global
user.name=prepoleved
user.email=prepoleved@gmail.com
core.editor=code
core.page=less -R
init.defaultbranch=main
```


## Configure basic things for new setup

```bash
git config --global user.name myname
git config --global user.email myemail@email.com
git config --global core.editor code
git config --global core.pager 'less -R'
git config --global init.defaultbranch=main
```

### Check configuration
```bash
git config --list # global settings for a user

```
These settings are stored in ~/.gitconfig

```bash
cat ~/.gitconfig 
[user]
	name = Preetam Openshift
	email = openshiftpreetam@gmail.com
[core]
	editor = code

# System Settings
git config --list
user.name=Preetam Openshift
user.email=openshiftpreetam@gmail.com
core.editor=code

# Global Settings
git config --list --global
user.name=Preetam Openshift
user.email=openshiftpreetam@gmail.com
core.editor=code
```

### Solution for multiple repo

in case you wish separate gitconfig per project, then you can  use
cd into specific project, this is project level settings.

```bash
cd myproject
git config user.name <yourName> --local
git config user.email <yourEmailAddress> --local
```

## Find the scope and source

git config --list --show-scope

```shell
# show scope
git config --list --show-scope
global  user.name=prepoleved
global  user.email=prepoleved@gmail.com
global  core.editor=code
global  core.page=less -R
global  init.defaultbranch=main
local   core.repositoryformatversion=0
local   core.filemode=true
local   core.bare=false
local   core.logallrefupdates=true
local   user.email=developer@gmail.com
local   user.name=developer

# show origin
git config --list --show-origin
file:/home/sapbmw/.gitconfig    user.name=prepoleved
file:/home/sapbmw/.gitconfig    user.email=prepoleved@gmail.com
file:/home/sapbmw/.gitconfig    core.editor=code
file:/home/sapbmw/.gitconfig    core.page=less -R
file:/home/sapbmw/.gitconfig    init.defaultbranch=main
file:.git/config        core.repositoryformatversion=0
file:.git/config        core.filemode=true
file:.git/config        core.bare=false
file:.git/config        core.logallrefupdates=true
file:.git/config        user.email=developer@gmail.com
file:.git/config        user.name=developer



```


## Reference

[Configure Git like a Pro](https://medium.com/@kszpiczakowski/configure-git-like-a-pro-meet-git-3-e48f82b1c346)

[Basic Git Setup](https://batsov.com/articles/2020/11/22/basic-git-setup/)