# Create a user on vagrant boxes

Idea: I like to have my own user on vagrant boxes
But by default, 

```shell
[vagrant@rheldev ~]$ sudo grep -i PasswordAuthentication /etc/ssh/sshd_config
PasswordAuthentication no
```

So here is what i do

```shell

ssh vagrant
export LOGINNAME=zorro
sudo useradd -c 'Mr.Zorro' $LOGINNAME
sudo passwd $LOGINNAME
echo -e "Defaults timestamp_timeout=60\\n$LOGINNAME ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$LOGINNAME
su $LOGINNAME
mkdir -pv $HOME/.ssh
chmod -vR u=rwX && chmod -vR og-rwx $HOME/.ssh
cd $HOME/.ssh
vim authorized_keys

# open a tab on your local machine
ssh-keygen -t ed25519 -C "Purpose of the key created on $(date +%F)"
# copy content of .pub file 
# now to the previous tab, paste it to the 
# file authorized_keys on the remote machine

# logout of LOGINNAME
# logout of vagrant

ssh LOGINNAME@ipofthevagrantmachine.
```
