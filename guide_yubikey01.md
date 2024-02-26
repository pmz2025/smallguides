# 101 Guide on Yubikey

This is the first guide, everyone has to follow you get the yubikey

## Pre-requisites

<need to fill in later on>
- yubikey-manager (yum install yubikey-manager -y)
- scdaemon (already installed)

## Reset Yubikey

This step is optional but i would mention it here because I would be using this in future.
Do note the default pins

```bash
ykman openpgp reset
WARNING! This will delete all stored OpenPGP keys and data and restore factory settings? [y/N]: y
Resetting OpenPGP data, don't remove the YubiKey...
Success! All data has been cleared and default PINs are set.
PIN:         123456
Reset code:  NOT SET
Admin PIN:   12345678
```

## Set Admin and PIN (user) on yubikey

This is important step to set the PIN. These PINs are specific to GPG operation.
FIDO is below

```bash
gpg --edit-card

Reader ...........: 1050:0407:X:0
Application ID ...: D2760001240103040006224623780000
Application type .: OpenPGP
Version ..........: 3.4
Manufacturer .....: Yubico
Serial number ....: 22462378
Name of cardholder: [not set]
Language prefs ...: [not set]
Salutation .......: 
URL of public key : [not set]
Login data .......: [not set]
Signature PIN ....: not forced
Key attributes ...: rsa2048 rsa2048 rsa2048
Max. PIN lengths .: 127 127 127
PIN retry counter : 3 0 3
Signature counter : 0
KDF setting ......: off
Signature key ....: [none]
Encryption key....: [none]
Authentication key: [none]
General key info..: [none]

```

### enter into admin mode

Tp set the pin/passwd, you must enter admin mode.

```bash
gpg/card> admin
Admin commands are allowed
```

you can use `?` to find help, now lets change the password/PIN for both admin and then user

```bash

gpg/card> passwd
gpg: OpenPGP card no. D2760001240103040006224623780000 detected

1 - change PIN
2 - unblock PIN
3 - change Admin PIN
4 - set the Reset Code
Q - quit

Your selection? 
```bash
Your selection? 3 # for admin pin
PIN changed.

1 - change PIN
2 - unblock PIN
3 - change Admin PIN
4 - set the Reset Code
Q - quit

Your selection? 1 # for normal pin
PIN changed.
-----

### Reset FIDO

This is again optional step because FIDO PIN is blank. You must set it

```bash
# check the status first
ykman fido info
PIN is set, with 8 attempt(s) remaining.
# from the above it is clear PIN is set. And I do not know the PIN.
# I will reset it.
ykman fido reset
WARNING! This will delete all FIDO credentials, including FIDO U2F credentials, and restore factory settings. Proceed? [y/N]: y
Remove and re-insert your YubiKey to perform the reset...
Touch your YubiKey...
```

Now lets set the pin. Remember it can be alphanumeric

```bash
ykman fido access change-pin
Enter your new PIN: 
Repeat for confirmation: 
```

## Set the Touch Policy

This is important step especially when you want to use Touch function for all operations e.g. when you want to read password from pass database. Yes, Pass is coming in future guides.

First check the status on the yubikey. By default touch policy is off.

```bash
OpenPGP version: 3.4
Application version: 5.4.3

PIN tries remaining: 3
Reset code tries remaining: 0
Admin PIN tries remaining: 3

Touch policies
Signature key           Off
Encryption key          Off
Authentication key      Off
Attestation key         Off
```

### Information

Before you start, check the help.

```bash
ykman openpgp keys set-touch -h

#  The most important help/cmd/options are pasted below
#   KEY     Key slot to set (sig, enc, aut or att).
#  POLICY  Touch policy to set (on, off, fixed, cached or cached-fixed).

# for each operation, you need to enter admin pin and confirm

# signed
ykman openpgp keys set-touch sig on
# encryped
ykman openpgp keys set-touch enc on
# authenticated
ykman openpgp keys set-touch aut on

# finally check
$ ykman openpgp info
OpenPGP version: 3.4
Application version: 5.4.3

PIN tries remaining: 3
Reset code tries remaining: 0
Admin PIN tries remaining: 3

Touch policies
Signature key           On
Encryption key          On
Authentication key      On
Attestation key         Off
[pzare@rhel22 20:46:19 ~]$ 
```


### Reference

- <https://digitalnotions.net/changing-the-yubikey-piv-pin/>
