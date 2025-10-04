# Notes on PGP or GnuPGP

## Introduction

All information gathered on PGP esp theory and some pro tips

- PGP stands for Pretty Good Privacy and WAS `pgp` 
- GnuPG is a complete and free implementation of the OpenPGP or as open source software. <br>
  Hence these days you heard gpg and not pgp
- GnuPG is available on all linux distribution
- GnuPG also provides support for S/MIME and SSH

### Home Directory

Home directory (homedir) is where GnuPG stores keyrings and private keys, and <br>
read configuration from (gpg.conf) <br>
$HOME/.gnupg is default Home Directory.

You can set your own home directory using $GNUPGHOME as environmental variable or you prepend all
command with `--homedir`

## What is included here?

- listing keys, deleting keys
- generating revocation certificate

### Listing keys

list keys (including subkeys)

```shell
➤ gpg --list-keys --with-subkey-fingerprint 
/home/sapbmw/newgpgkeys/pubring.kbx
-----------------------------------
pub   ed25519 2025-09-12 [C] [expires: 2028-09-11]
      604AF1A9CF657990CA280E1D0D3F7AA4B8AE629C  # <- primary key | fingerprints
uid           [ultimate] nodiesop <nodiesop@gmail.com> # this is my identity.
sub   ed25519 2025-09-12 [S] [expires: 2027-09-12] # <- subkey with Signing capability  | fingerprints
      C8B8546EE60AF790279E7345B58979650ADF398E
sub   ed25519 2025-09-12 [A] [expires: 2027-09-12] # <- subkey with Authentication capability | fingerprints
      90628AA69FA06A549FF66260A6881F8DCCD2DF8D
sub   cv25519 2025-09-12 [E] [expires: 2027-09-12] # <- subkey with Encryption capability | fingerprints
      B1679EB215C10026B01D894BBE3A5091E349E2D9
```

#### List secret keys

```shell

➤ gpg --list-secret-keys --keyid-format long
[keyboxd]
---------
sec#  ed25519/56DD6A2CB5829A9B 2025-04-19 [C]
      F9E59AC7E9ACD99700C0915856DD6A2CB5829A9B
uid                 [ultimate] Preetam Zare (On Fedora) <preetamzare@gmail.com>
ssb>  ed25519/87E309472536237E 2025-04-19 [S] [expires: 2027-04-19]
ssb>  ed25519/C6105623D898B80D 2025-04-19 [A] [expires: 2027-04-19]
ssb>  rsa4096/75C11336DB676992 2025-04-19 [E] [expires: 2027-04-19]

```



## Identities

You can have multiple identities associated with key.
Identity usually contains email address and name.
In the above example, i have only one identity.

## Keys

Every GnuPGP has a primary key (master key) and one
or more subkeys. Subkeys are mentioned above and their capabilities.

But if you create a key with capabilities, it will have [C] and [S] function.
And there will be subkey with [E] capability

## Fingerprints

Fingerprints are hashes of your public key.
Primary key fingerprint is called Key ID.

### What is keyrings?

Keyring is set of files which contains
- secret keys
- public keys

These keys are stored in .gnupg directory.
And when you export your keys, they are exported from this directory i.e. from your keyring

### How to export your public key

you must export your public key and share with others.
This is must because the other person
needs your public key to encrypt the message.
A message encrypted with public key, can be
decrypted only by private key of person, whose
public key was used.

you can export key in 

- binary format.
- ASCII-armored format. (Human readable)

gpg --export --armor <FingerPrintOfTheKey> # Fingerprint, you will find in gpg --list-keys --with-subkey-fingerprint

gpg --export --armor --output $KEYID.pub.asc $KEYID


### How to import key?

there are multiple ways, simple way is

gpg --import <key.pub.asc> # extension is only a information.

gpg --import 
# screen waits for you to paste the
```shell
----- PUBLIC KEY BLOCK ----- 

-----END PGP PUBLIC KEY BLOCK-----
```
### Listing keys

Now that you imported or created keys and they are stored
in keyring, you verify them using

```shell
gpg -k  # list public key or longer version is
gpg --list-public-keys

gpg -K # list secret keys or longer version is
gpg --list-secret-keys
```

### Deleting keys

```shell
# deleting public and secret key stored in non-default homedirectory
gpg --homedir $GNUPGHOME --delete-secret-and-public-key 1E11AC7B7E9C5FAF5E6F8731C84E3FAAE02B4F61
```

### How to create revocation certificate


gpg --gen-revoke <key> > revocation.asc

But this is not sufficient, the end user must import the certificate
in his keyring

> But before you do this, 
please check if there is no
`:` infront `----- BEGIN PGP xxx -----`
This means, the key is commented
and must be uncommented.

gpg --import revocation.asc

## What is Openpgp Card?

It is card which has 

- chip
- storage: to store primary and sub keys
- software: do encryption and decryption operations

## Before importing the keys

Before importing the keys, check what inside the keys

gpg --show-keys 

```bash
➤ gpg --show-keys $HOME/Documents/smallguides/GPG_GnuPG/jms1.pub.asc 
pub   rsa4096 2019-03-21 [SC] [expires: 2026-01-01]
      E3F7F5F76640299C5507FBAA49B9FD3BB4422EBB
uid                      John Simpson <jms1@jms1.net>
uid                      John Simpson <kg4zow@mac.com>
uid                      John Simpson <kg4zow@kg4zow.us>
sub   rsa4096 2019-03-21 [E] [expires: 2026-01-01]
sub   rsa4096 2019-03-21 [S] [expires: 2026-01-01]
sub   rsa4096 2019-03-21 [A] [expires: 2026-01-01]

# another example is with Fedora key

➤ gpg --show-keys --with-fingerprint --keyid-format long fedora.gpg
pub   rsa4096/D0622462E99D6AD1 2023-08-08 [SCE]
      Key fingerprint = 466C F2D8 B60B C305 7AA9  453E D062 2462 E99D 6AD1
uid                            Fedora (41) <fedora-41-primary@fedoraproject.org>

pub   rsa4096/C8AC4916105EF944 2024-02-12 [SCE]
      Key fingerprint = B0F4 9504 58F6 9E11 50C6  C5ED C8AC 4916 105E F944
uid                            Fedora (42) <fedora-42-primary@fedoraproject.org>

pub   rsa4096/829B606631645531 2024-08-10 [SCE]
      Key fingerprint = C6E7 F081 CF80 E131 4667  6E88 829B 6066 3164 5531
uid                            Fedora (43) <fedora-43-primary@fedoraproject.org>

pub   rsa4096/DBFCF71C6D9F90A6 2025-01-14 [SCE]
      Key fingerprint = 36F6 12DC F27F 7D1A 48A8  35E4 DBFC F71C 6D9F 90A6
uid                            Fedora (44) <fedora-44-primary@fedoraproject.org>


```