# PGP or gnuPG

Here we are discussing 

- how to create keys

Before we start creating key, i always like to create a directory where my keys will be stored

```shell
mkdir -pv  $HOME/newgpgkeys
export GNUPGHOME=$HOME/newgpgkeys 

# in fish shell (optionally)
set -gx GNUPGHOME $HOME/newgpgkeys

# check if the environmental variable is
gpgconf -L

# change permissions
chmod 0700 $GNUPGHOME

gpg --full-gen-key

gpg: keybox '/home/sapbmw/Documents/newgpgkeys/pubring.kbx' created
Please select what kind of key you want:
   (1) RSA and RSA
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
   (9) ECC (sign and encrypt) *default* # default
  (10) ECC (sign only)
  (14) Existing key from card
Your selection? 9
Please select which elliptic curve you want:
   (1) Curve 25519 *default* # default
   (4) NIST P-384
   (6) Brainpool P-256
Your selection? 1
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 2y
Key expires at Sun 12 Sep 2027 08:37:00 AM CEST
Is this correct? (y/N) y

GnuPG needs to construct a user ID to identify your key.

Real name: repolevedp
Email address: repolevedp@gmail.com
Comment: Lets Do Development
You selected this USER-ID:
    "repolevedp (Lets Do Development) <repolevedp@gmail.com>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O

gpg: /home/sapbmw/Documents/newgpgkeys/trustdb.gpg: trustdb created
gpg: directory '/home/sapbmw/Documents/newgpgkeys/openpgp-revocs.d' created
gpg: revocation certificate stored as '/home/sapbmw/Documents/newgpgkeys/openpgp-revocs.d/EFE99818EC66B5D47D04FC534057F21FD097EF3E.rev'
public and secret key created and signed.

pub   ed25519 2025-09-12 [SC] [expires: 2027-09-12]
      EFE99818EC66B5D47D04FC534057F21FD097EF3E
uid                      repolevedp (Lets Do Development) <repolevedp@gmail.com>
sub   cv25519 2025-09-12 [E] [expires: 2027-09-12]

```

On most normal PGP keys, the primary key has both [SC] (as seen above), so it means, this key can be used for both signing and certifying. But this not standard practice because you do not have to store the primary key on yubikey and if one of the subkey is compromised, we simply can revoke the signing key, instead of revoking everything.