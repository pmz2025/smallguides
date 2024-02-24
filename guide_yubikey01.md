# 101 Guide on Yubikey

This is the first guide, everyone has to follow you get the yubikey

## Pre-requisites

<need to fill in later on>

## Reset Yubikey

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

### Reference

- <https://digitalnotions.net/changing-the-yubikey-piv-pin/>
