# GPG and Yubikey


## Transfer Keys to Card

You need to transfer keys to card. But remember you need to export your keys before doing so.
I have done this. But I will update this part later on. But for time being, when you are finished transfering your key to card, 

!!! Do not type save, INSTEAD type quit and press N and Y

```bash
# edit key
gpg --edit-key preetamzare@gmail.com

# list the keys
gpg> key

sec  rsa4096/3F03DA612E5F11A7
     created: 2024-02-25  expires: never       usage: C   
     trust: ultimate      validity: ultimate
ssb  rsa4096/78F919DAEB962A47
     created: 2024-02-25  expires: never       usage: E   
ssb  rsa4096/73731D02F7C9426E
     created: 2024-02-25  expires: never       usage: S   
ssb  rsa4096/F42B5D9EF94A7CD4
     created: 2024-02-25  expires: never       usage: A   
[ultimate] (1). Preetam <preetamzare@gmail.com>

# select key 1, you will see * mark infront of the key e.g. ssb*
# you will need passphrase for secret key and admin PIN
gpg> key 1

sec  rsa4096/3F03DA612E5F11A7
     created: 2024-02-25  expires: never       usage: C   
     trust: ultimate      validity: ultimate
ssb* rsa4096/78F919DAEB962A47
     created: 2024-02-25  expires: never       usage: E   
ssb  rsa4096/73731D02F7C9426E
     created: 2024-02-25  expires: never       usage: S   
ssb  rsa4096/F42B5D9EF94A7CD4
     created: 2024-02-25  expires: never       usage: A   
[ultimate] (1). Preetam <preetamzare@gmail.com>

gpg> keytocard
Please select where to store the key:
   (2) Encryption key
Your selection? 2

# deselect key 1 before proceeding further, then select key 2

gpg> key 2

sec  rsa4096/3F03DA612E5F11A7
     created: 2024-02-25  expires: never       usage: C   
     trust: ultimate      validity: ultimate
ssb  rsa4096/78F919DAEB962A47
     created: 2024-02-25  expires: never       usage: E   
ssb* rsa4096/73731D02F7C9426E
     created: 2024-02-25  expires: never       usage: S   
ssb  rsa4096/F42B5D9EF94A7CD4
     created: 2024-02-25  expires: never       usage: A   
[ultimate] (1). Preetam <preetamzare@gmail.com>

gpg> keytocard
Please select where to store the key:
   (1) Signature key
   (3) Authentication key
Your selection? 1

sec  rsa4096/3F03DA612E5F11A7
     created: 2024-02-25  expires: never       usage: C   
     trust: ultimate      validity: ultimate
ssb  rsa4096/78F919DAEB962A47
     created: 2024-02-25  expires: never       usage: E   
ssb* rsa4096/73731D02F7C9426E
     created: 2024-02-25  expires: never       usage: S   
ssb  rsa4096/F42B5D9EF94A7CD4
     created: 2024-02-25  expires: never       usage: A   
[ultimate] (1). Preetam <preetamzare@gmail.com>

# deselect key 2
gpg> key 2

sec  rsa4096/3F03DA612E5F11A7
     created: 2024-02-25  expires: never       usage: C   
     trust: ultimate      validity: ultimate
ssb  rsa4096/78F919DAEB962A47
     created: 2024-02-25  expires: never       usage: E   
ssb  rsa4096/73731D02F7C9426E
     created: 2024-02-25  expires: never       usage: S   
ssb  rsa4096/F42B5D9EF94A7CD4
     created: 2024-02-25  expires: never       usage: A   
[ultimate] (1). Preetam <preetamzare@gmail.com>

# select key 3
gpg> key 3

sec  rsa4096/3F03DA612E5F11A7
     created: 2024-02-25  expires: never       usage: C   
     trust: ultimate      validity: ultimate
ssb  rsa4096/78F919DAEB962A47
     created: 2024-02-25  expires: never       usage: E   
ssb  rsa4096/73731D02F7C9426E
     created: 2024-02-25  expires: never       usage: S   
ssb* rsa4096/F42B5D9EF94A7CD4
     created: 2024-02-25  expires: never       usage: A   
[ultimate] (1). Preetam <preetamzare@gmail.com>

gpg> keytocard
Please select where to store the key:
   (3) Authentication key
Your selection? 3

# deselect key 3
gpg> key 3

sec  rsa4096/3F03DA612E5F11A7
     created: 2024-02-25  expires: never       usage: C   
     trust: ultimate      validity: ultimate
ssb  rsa4096/78F919DAEB962A47
     created: 2024-02-25  expires: never       usage: E   
ssb  rsa4096/73731D02F7C9426E
     created: 2024-02-25  expires: never       usage: S   
ssb  rsa4096/F42B5D9EF94A7CD4
     created: 2024-02-25  expires: never       usage: A   
[ultimate] (1). Preetam <preetamzare@gmail.com>

# VERY IMPORTANT Step. Do not write Save here unless you have exported the keys
# Instead type quit, press y


gpg> quit
# press N
Save changes? (y/N) 
# press y
Quit without saving? (y/N) 


```
## Check if the Touch policies are ON

```bash
$ ykman openpgp info
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

$ ykman openpgp keys set-touch sig on
Enter Admin PIN: 
Set touch policy of signature key to on? [y/N]: y

$ ykman openpgp keys set-touch enc on
Enter Admin PIN: 
Set touch policy of encryption key to on? [y/N]: y

$ ykman openpgp keys set-touch aut on
Enter Admin PIN: 
Set touch policy of authentication key to on? [y/N]: y

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
[pzare@rhel22 06:16:19 ~]$ 

```
