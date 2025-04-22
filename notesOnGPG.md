# Notes on GPG

These are my understanding but it is based on the guide by John Simpson
First it all started with PGP and the GNU took over and hence it P got replaced with G.
Though yubikey continues to refer it is as open pgp. 

## Generating keys

Always setup a environment variable to GNUPGHOME. This ensures your existing keys are not overwritten by mistake or you can specific use --home

### Generate primary key

Use the `gpg --quick-gen-key` command when you wish to 

- exact expiry date
- want to do it quickly

```bash

gpg --quick-gen-key 'Preetam <be.preetam@gmail.com>' ed25519 cert 2026-01-01

# ed25519 is the key type
# here 'cert' is the purpose of the key. The other purpose could be (encrypt, sign, auth)
# date (rather exact date) yyyy-mm-dd format

```

### Generate sub keys

We will generate signing (S) , encryption (E) and authentication (A) keys. 
Since these keys are based on primary key (Cert), we will replace `gen` with `add` command

```bash
export KEYID='DD0080CFEE948F567B952E0F534AA4E63C3E1260'
gpg --quick-add-key $KEYID ed25519 sign 2025-06-01

[$] gpg --list-keys
/home/poseidon/test_gpgkeys/pubring.kbx
---------------------------------------
pub   ed25519 2025-03-05 [C] [expires: 2026-01-01]
      DD0080CFEE948F567B952E0F534AA4E63C3E1260
uid           [ultimate] Preetam <be.preetam@gmail.com>
sub   ed25519 2025-03-05 [S] [expires: 2026-06-01]
```

### Generate key for encrypting, note rsa4096

```bash
gpg --quick-add-key $KEYID rsa4096 encrypt 2025-06-01

[>]$ gpg --list-keys
/home/poseidon/test_gpgkeys/pubring.kbx
---------------------------------------
pub   ed25519 2025-03-05 [C] [expires: 2026-01-01]
      DD0080CFEE948F567B952E0F534AA4E63C3E1260
uid           [ultimate] Preetam <be.preetam@gmail.com>
sub   ed25519 2025-03-05 [S] [expires: 2026-06-01]
sub   rsa4096 2025-03-05 [E] [expires: 2025-06-01]

```
### Using --homedir

In case, you have multiple directories for gpg, then use

```bash
gpg -k --homedir ~/test_gpgkeys

gpg --quick-add-key $KEYID rsa4096 auth 2025-06-01

[>]$ gpg --list-keys
/home/poseidon/test_gpgkeys/pubring.kbx
---------------------------------------
pub   ed25519 2025-03-05 [C] [expires: 2026-01-01]
      DD0080CFEE948F567B952E0F534AA4E63C3E1260
uid           [ultimate] Preetam <be.preetam@gmail.com>
sub   ed25519 2025-03-05 [S] [expires: 2026-06-01]
sub   rsa4096 2025-03-05 [E] [expires: 2025-06-01]
sub   rsa4096 2025-03-05 [A] [expires: 2025-06-01]

```

Always remember primary key will certificate all sub keys and by separting functions you do not have to place primary key on yubikey.  And another advantage is, if you wish to revoke any of the sub keys you do not have do the whole process again.

## Exporting Keys

Key exporting is must or required when you wish

- encrypt
- sign

`gpg --export --armor --output $KEYID.pub $KEYID`


## Encryption

To encrypt a data, you need two things

- recipient: this can be either a public key which you have imported or simple name. I need to elaborate more on this.
- encrypt

```bash
gpg --encrypt --recipient 'Preetam Zare' encryption/encrypted.txt
```


## Reference

- [how to encrypt files](https://edoceo.com/sys/gpg)
- [GPG Quick Start](https://www.madboa.com/geek/gpg-quickstart/)
- [Ultimate Guide for GPG](https://yubikey.jms1.info/introduction.html)