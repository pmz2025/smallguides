# Configure Yubikey with Fedora 42 for loging

I'm doing this based on the article [In Fedora website](https://docs.fedoraproject.org/en-US/quick-docs/using-yubikeys/). I found few references which I need to memorize and hence this article.

## How to find if your yubikey has u2f?

```bash
➤ ykman info
Device type: YubiKey 5C
Serial number: 14456345
Firmware version: 5.2.7
Form factor: Keychain (USB-C)
Enabled USB interfaces: OTP, FIDO, CCID

Applications
Yubico OTP   Enabled
FIDO U2F     Enabled # confirms you have U2F
FIDO2        Enabled
OATH         Enabled
PIV          Enabled
OpenPGP      Enabled
YubiHSM Auth Not available
```

Since I have U2F, I would be documenting only for pam_u2f manual.

create two files as shown below

```shell
sudo touch /etc/pam.d/u2f-{required,sufficient}

cat <<EOF | sudo tee /etc/pam.d/u2f-required
> #%PAM-1.0
auth       required     pam_u2f.so
> EOF

cat <<EOF | sudo tee /etc/pam.d/u2f-sufficient
#%PAM-1.0
auth       sufficient     pam_u2f.so
EOF
```

### Difference between sufficient and required

sufficient only expect the user is present and can touch yubikey, but required means, user is present and must enter his password to confirm he is there and he has the credentials. In other words, required is more secure but personally i feel it is too much for a local laptop but if you are travellig often, it is expected that you remove the yubikey before you leave the laptop lying around

## Register yubikey(s) with your local account

I mentioned above yubikeys in plural because if you lose this key, you may lock yourself out unless you are know the root password.

```shell

mkdir -pv $HOME/.config/Yubico
# you need a Fido PIN for the next command to work
pamu2fcfg >> $HOME/.config/Yubico/u2f_keys

# since we need two keys as backup

pamu2fcfg -n >> $HOME/.config/Yubico/u2f_keys

```

### configuring sudo and login with yubikey without password i.e. passwordless

In order to have passwordless configuration, you need to use sufficient label. For sudo, the file is located under /etc/pam.d/sudo and for login the file is /etc/pam.d/gdm-password

```shell
# sudo file content
➤ cat /etc/pam.d/sudo
#%PAM-1.0
auth       include      u2f-sufficient # sufficient is always above the linke which is auth substack system-auth
auth       substack     system-auth
account    include      system-auth
password   include      system-auth
session    optional     pam_keyinit.so revoke
session    required     pam_limits.so
session    include      system-auth

cat gdm-password
auth     [success=done ignore=ignore default=bad] pam_selinux_permit.so
auth        include       u2f-sufficient # this line was added
auth        substack      password-auth
auth        optional      pam_gnome_keyring.so
auth        include       postlogin

account     required      pam_nologin.so
account     include       password-auth

password    substack       password-auth
-password   optional       pam_gnome_keyring.so use_authtok

session     required      pam_selinux.so close
session     required      pam_loginuid.so
session     required      pam_selinux.so open
session     optional      pam_keyinit.so force revoke
session     required      pam_namespace.so
session     include       password-auth
session     optional      pam_gnome_keyring.so auto_start
session     include       postlogin

```
