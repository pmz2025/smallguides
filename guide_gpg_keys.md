# Guide to create a GPG Keys

Here is small guide which I always follow to create GPG Keys.


## Steps to create master key

As a first steps we generate master key to certify and it is our master key. The Certify key is responsible for issuing Subkeys for encryption, signature and authentication operations.


```bash

gpg --full-generate-key --expert

Possible actions for this RSA key: Sign Certify Encrypt Authenticate 
Current allowed actions: Certify # <-- Ensure this is always selected i.e. you need to toggle other options

   (S) Toggle the sign capability
   (E) Toggle the encrypt capability
   (A) Toggle the authenticate capability
   (Q) Finished

Your selection? q
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (3072) 4096 # select the highest available key size
Requested keysize is 4096 bits
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) # <-- Since it is master key, you should select this non-expiring
Key does not expire at all
Is this correct? (y/N) y # <-- Press y to proceed further

GnuPG needs to construct a user ID to identify your key.

Real name: Preetam Zare
Email address: preetamzare@gmail.com
Comment: Preetam Zare on RHELL
You selected this USER-ID:
    "Preetam Zare (Preetam Zare on RHELL) <preetamzare@gmail.com>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
gpg: /home/pzare/.gnupg/trustdb.gpg: trustdb created
gpg: key 4259C25BFBE68E0B marked as ultimately trusted
gpg: directory '/home/pzare/.gnupg/openpgp-revocs.d' created
gpg: revocation certificate stored as '/home/pzare/.gnupg/openpgp-revocs.d/89EBBFA1D0A2B73849A566EF4259C25BFBE68E0B.rev'
public and secret key created and signed.

pub   rsa4096 2024-08-24 [C]
      89EBBFA1D0A2B73849A566EF4259C25BFBE68E0B # <-- this is fingerprint 
uid                      Preetam Zare (Preetam Zare on RHELL) <preetamzare@gmail.com> #<-- this is your id

```
What is not shown in this guide but i personal feel important to mention. 
You must enter a paraphrase for the master key and this is required in future steps. 
So always remember this part.

### Where is public and private key?

```bash
gpg -k --with-colons 
tru::1:1728846622:0:3:1:5
pub:u:255:22:32D2A53DFC85DC57:1728846406:::u:::cC:::::ed25519:::0:
fpr:::::::::A6756AB26A1D1754993FC74932D2A53DFC85DC57:
uid:u::::1728846406::83ECCBACBE4B048F1FA4086A49BEF93EF724492E::Preetam Zare (Preetam Zare) 

public key is 32D2A53DFC85DC57
private key is A6756AB26A1D1754993FC74932D2A53DFC85DC57
```

## Steps to create sub keys

We are going to create three subkeys and each has its own purpose.

- encryption
- authentication
- Signing

```bash

[pzare@rhel22 21:51:28 ~]$ gpg --edit-key --expert preetamzare@gmail.com # <-- we are using id of the primary key
gpg (GnuPG) 2.3.3; Copyright (C) 2021 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Secret key is available.

gpg: checking the trustdb
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
sec  rsa4096/4259C25BFBE68E0B # <-- master key
     created: 2024-08-24  expires: never       usage: C   # <-- usage C which stands for certify
     trust: ultimate      validity: ultimate
[ultimate] (1). Preetam Zare (Preetam Zare on RHELL) <preetamzare@gmail.com>

gpg> addkey # <-- type Add key
Please select what kind of key you want:
   (3) DSA (sign only)
   (4) RSA (sign only)
   (5) Elgamal (encrypt only)
   (6) RSA (encrypt only)
  (14) Existing key from card
Your selection? 4 # <-- select the RSA key for signing purpose
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (3072) 4096 # <- select highest available
Requested keysize is 4096 bits
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 3y # <-- select three years
Key expires at Tue 24 Aug 2027 09:52:39 PM CEST
Is this correct? (y/N) y
Really create? (y/N) y # <-- after this step, you will need a paraphrase for the master key
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.

sec  rsa4096/4259C25BFBE68E0B # <-- this is last 16 characters of my master key (which is same as above)
     created: 2024-08-24  expires: never       usage: C   
     trust: ultimate      validity: ultimate
ssb  rsa4096/0A46D51027E46FAD
     created: 2024-08-24  expires: 2027-08-24  usage: S   # <-- key created for the signing purpose>
[ultimate] (1). Preetam Zare (Preetam Zare on RHELL) <preetamzare@gmail.com>

```

Similarly you can create key for Authentication. I have not shown the process to avoid repetition.

## Create another key for encrypting
The reason I'm showing encryption key is because you must select RSA (set your own capabilities)
In the below screen, you see now 1 master key and 3 subkeys

```bash

sec  rsa4096/4259C25BFBE68E0B # <-- master key
     created: 2024-08-24  expires: never       usage: C   
     trust: ultimate      validity: ultimate
ssb  rsa4096/054729E9E3759AA9 # <-- subkey for signing
     created: 2024-08-24  expires: 2027-08-24  usage: S   
ssb  rsa4096/97D31F889F91AEA9 # <-- subkey for encryption
     created: 2024-08-24  expires: 2027-08-24  usage: E   
ssb  rsa4096/5E664F9871955F25 # <-- subkey for authentication
     created: 2024-08-24  expires: 2027-08-24  usage: A   
[ultimate] (1). Preetam Zare (Preetam Zare on RHELL) <preetamzare@gmail.com>

```

## Steps for exporting keys

First create a directory e.g. mkdir mygpgkeys

```bash
# first master secret key
gpg --armor --export-secret-keys preetamzare@gmail.com > mygpgkeys/master.key

# generate revocation certificate
gpg --gen-revoke preetamzare@gmail.com > mygpgkeys/revoke.asc

# export master public key
gpg --armor --export preetamzare@gmail.com >mygpgkeys/master.pub

# export secret sub keys
gpg --armor --export-secret-subkeys > mygpgkeys/subkeys.key

# export fingerprints of all keys
gpg --fingerprint --fingerprint preetamzare@gmail.com

# list secret keys

[pzare@rhel22 22:16:28 ~]$ gpg --list-secret-keys 
/home/pzare/.gnupg/pubring.kbx
------------------------------
sec   rsa4096 2024-08-24 [C]
      89EBBFA1D0A2B73849A566EF4259C25BFBE68E0B
uid           [ultimate] Preetam Zare (Preetam Zare on RHELL) <preetamzare@gmail.com>
ssb   rsa4096 2024-08-24 [S] [expires: 2027-08-24]
ssb   rsa4096 2024-08-24 [E] [expires: 2027-08-24]
ssb   rsa4096 2024-08-24 [A] [expires: 2027-08-24]

```

In oder to add these keys to yubikey, you can follow guide guide_yukikey02.md

## Reference

[Ultimate Guide for GPG](https://yubikey.jms1.info/introduction.html)