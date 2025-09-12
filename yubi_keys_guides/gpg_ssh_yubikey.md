# How to configure Yubikey for SSH Authentication

This guide talks

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
now check which keys are shown using 

`ssh-add -L` # show keys, but small l (`-l`) show fingerprints. It might now show the right keys, in case just restart the gpg-agent as shown below

```shell
➤ ssh-add -l
256 SHA256:yd8Mx1nYJYrvS/dKFCox4By805wAI3O4S65utntVnmU cardno:14_456_345 (ED25519)
256 SHA256:w3rqhP23t+6NGWJ3eTNDDL8mEgt6gRf7XuRC2nUExwg dposeidon__satorni2025-05-09 (ED25519)

# above output shows old keys, now restart the gpg-agent

➤ systemctl --user restart gpg-agent.service 

# after restart output now makes senses
➤ ssh-add -l
256 SHA256:yd8Mx1nYJYrvS/dKFCox4By805wAI3O4S65utntVnmU cardno:14_456_345 (ED25519)
256 SHA256:w3rqhP23t+6NGWJ3eTNDDL8mEgt6gRf7XuRC2nUExwg dposeidon__satorni2025-05-09 (ED25519)

```

Now, once this is done, simply use ssh-copy-id command to transfer the key to remote server. You will be asked admin key and touch to copy the key.



>Do note, you need public key of your master key on the client from where you are planning to copy the key.

