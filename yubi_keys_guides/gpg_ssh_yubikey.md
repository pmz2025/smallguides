# How to configure Yubikey for SSH Authentication

This guide talks on how to configure gpg to use ssh based authentication against a server.
Here gpg public key (Authentication Key) is stored on yubikey.
You can also you FIDO for SSH based authenticating against server.
THat guide is is guide_ssh_yubikey.md
But with GPG you do not have to maintain additional ssh-key.
GnuPG will automatically detect the key on the card and add it to
the gpg-agent and is visible using ssh-add -L.

>NB: This key | fingerprint is not visible when you gpg --list-keys,
you can see this ssh key using 

`gpg --export-ssh-key $KEYID`

## Steps

The pre-requisite is
- you have followed the guide_yubikey01 and guide_yubikey02
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

# you must export the variable for child process to use it
export SSH_AUTH_SOCK=$(gpgconf --list-dir agent-ssh-socket)

# on fish shell
set -gx SSH_AUTH_SOCK $(gpgconf --list-dir agent-ssh-socket)
echo $SSH_AUTH_SOCK

```
Now check which keys are shown using `ssh-add` command as shown below.

```shell
ssh-add -L
# show keys, but small l (`-l`) show fingerprints. 

➤ ssh-add -l
256 SHA256:yd8Mx1nYJYrvS/dKFCox4By805wAI3O4S65utntVnmU cardno:14_456_345 (ED25519)
256 SHA256:w3rqhP23t+6NGWJ3eTNDDL8mEgt6gRf7XuRC2nUExwg dposeidon__satorni2025-05-09 (ED25519)

# above output shows old keys, now restart the gpg-agent
# It might not show the right keys, in case just restart the gpg-agent as shown below

➤ systemctl --user restart gpg-agent.service

# after restart output now makes senses
➤ ssh-add -l
256 SHA256:yd8Mx1nYJYrvS/dKFCox4By805wAI3O4S65utntVnmU cardno:14_456_345 (ED25519)
256 SHA256:w3rqhP23t+6NGWJ3eTNDDL8mEgt6gRf7XuRC2nUExwg dposeidon__satorni2025-05-09 (ED25519)

```

Now, once this is done, simply use ssh-copy-id command to transfer the key to remote server. You will be asked admin key and touch to copy the key.

>Do note, you need public key of your master key on the client from where you are planning to copy the key.

## Good to know

Since we are using gpg's authentication key, which is available on the card, sshcontrol file is created
with keygrip

By the way, you can find the keygrip using the following command

```shell
➤ gpg --list-keys --with-keygrip
/home/sapbmw/newgpgkeys/pubring.kbx
-----------------------------------
pub   ed25519 2025-09-12 [C] [expires: 2028-09-11]
      604AF1A9CF657990CA280E1D0D3F7AA4B8AE629C
      Keygrip = 5D6082253E12EB3207CC5299E173C9BFC353A261
uid           [ultimate] nodiesop <nodiesop@gmail.com>
sub   ed25519 2025-09-12 [S] [expires: 2027-09-12]
      Keygrip = BA06A7F71125FA0DBC01E1C64478ED0A6768BBB1
sub   ed25519 2025-09-12 [A] [expires: 2027-09-12]
      Keygrip = D15684C611957C6775534508E412A1E9E356FCCA
sub   cv25519 2025-09-12 [E] [expires: 2027-09-12]
      Keygrip = BAD03919A435897A7B02D906E5A3C6ECB90BDE39
```