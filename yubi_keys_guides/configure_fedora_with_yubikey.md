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

touch /etc/pam.d/u2f-{required,sufficient}
