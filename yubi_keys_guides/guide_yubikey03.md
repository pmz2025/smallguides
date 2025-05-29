# How to configure Yubikey for SSH Authentication

Now there is already a guide by name guide_ssh_yubikey.md. This is just an additional one. But this focuses more on server authentication and much simpler.

## Steps

- you have followed guide_yubikey01 and guide_yubikey02
- now check the SSH socket variable using the following command

```bash
echo $SSH_AUTH_SOCK
# by default it is /run/user/1000/keyring/ssh
# we need to change this so that public key of our master key is copied

gpgconf --list-dir

sysconfdir:/etc/gnupg
bindir:/usr/bin
libexecdir:/usr/libexec
libdir:/usr/lib64/gnupg
datadir:/usr/share/gnupg
localedir:/usr/share/locale
socketdir:/run/user/1000/gnupg
dirmngr-socket:/run/user/1000/gnupg/S.dirmngr
keyboxd-socket:/run/user/1000/gnupg/S.keyboxd
agent-ssh-socket:/run/user/1000/gnupg/S.gpg-agent.ssh
agent-extra-socket:/run/user/1000/gnupg/S.gpg-agent.extra
agent-browser-socket:/run/user/1000/gnupg/S.gpg-agent.browser
agent-socket:/run/user/1000/gnupg/S.gpg-agent
homedir:/home/pzare/.gnupg

# since we are interested only in ssh socket

[pzare@rhel22 12:12:19 ~]$ gpgconf --list-dir agent-ssh-socket
/run/user/1000/gnupg/S.gpg-agent.ssh

SSH_AUTH_SOCK=$(gpgconf --list-dir agent-ssh-socket)

# Optionally it is recommended to export this variable via your bash script

export SSH_AUTH_SOCK=$(gpgconf --list-dir agent-ssh-socket)

```
Now, once this is done, simply use ssh-copy-id command to transfer the key to remote server. You will be asked admin key and touch to copy the key

>Do note, you need public key of your master key on the client from where you are planning to copy the key.

