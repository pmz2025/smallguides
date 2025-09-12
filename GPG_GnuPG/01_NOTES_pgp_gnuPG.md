# Notes on PGP or GnuPGP

All information gathered on PGP esp theory and some pro tips

- PGP stands for Pretty Good Privacy and WAS `pgp` 
- GnuPG implemented GPG but as OpenPGP or as open source software. Hence these days you heard gpg and not pgp
- GnuPG is available on all linux distribution
- listing keys, deleting keys
- generating revocation certificate

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

