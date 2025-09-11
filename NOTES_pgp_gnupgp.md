# Notes on PGP or GnuPGP

All information gathered on PGP esp theory and some pro tips

- PGP stands for Pretty Good Privacy and WAS `pgp` 
- GnuPG implemented GPG but as OpenPGP or as open source software. Hence these days you heard gpg and not pgp
- GnuPG is available on all linux distribution

```shell
➤ gpg --list-keys --with-subkey-fingerprint 
[keyboxd]
---------
pub   ed25519 2025-04-19 [C]
      F9E59AC7E9ACD99700C0915856DD6A2CB5829A9B # primary key | fingerprints
uid           [ultimate] Preetam Zare (On Fedora) <preetamzare@gmail.com> # this is my identity.
sub   ed25519 2025-04-19 [S] [expires: 2027-04-19] # subkey with Signing capability  | fingerprints
      645003D587739389CF30D31887E309472536237E
sub   ed25519 2025-04-19 [A] [expires: 2027-04-19] # subkey with Authentication capability | fingerprints
      9D9A323AF08542FC06EB90B2C6105623D898B80D
sub   rsa4096 2025-04-19 [E] [expires: 2027-04-19] # subkey with Encryption capability | fingerprints
      F3F0043E2CE5160500556C9375C11336DB676992
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

you can export key in 

- binary format.
- ASCII-armored format. (Human readable)

gpg --export --armor <FingerPrintOfTheKey> # Fingerprint, you will find in gpg --list-keys --with-subkey-fingerprint 


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
gpg --delete-keys # deletes only public keys

gpg --delete-secret-keys # deletes only secret keys

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

## How to

Here is all how to questions answered

