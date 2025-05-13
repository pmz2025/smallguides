# How to restore GPG Keys

Double check that you are working in the right gnupg home: 

``` bash
export KEYID='1B09CFB4D8F24E49863868426169DBEFBA429251'
```

Check that it's only showing your old subkeys with '>' option

``` bash
gpg --list-secret-keys $KEYID
```

``` bash
[poseidon@dell03 ~]$ gpg --list-secret-keys $KEYID
sec#  ed25519 2024-12-30 [C]
      1B09CFB4D8F24E49863868426169DBEFBA429251
uid           [ unknown] Preetam Zare <preetamzare@gmail.com>
ssb>  ed25519 2024-12-30 [S] [expires: 2026-12-30]
ssb>  ed25519 2024-12-30 [A] [expires: 2026-12-30]
ssb>  rsa4096 2024-12-30 [E] [expires: 2026-12-30]

```

Delete your private key, as long as you have backup. In my case it is restored in my mygpgkeys folder

``` bash
gpg --delete-secret-key $KEYID.
```
Import back the private subkeys you have exported, and the updated public key, please note we are not importing secret/primary key

``` bash
gpg --import mygpgkeys/master.pub 
gpg --import mygpgkeys/subkeys.key 
```

Check with that you have all of the subkeys and that the master key shows sec# instead of just sec.
``` bash
gpg --list-secret-keys $KEYID
```
Move the keys into yubikeys following the normal method

``` bash
gpg --edit-key $KEYID
trust
# selection option = 5
```

## Reference

[Restore GPG Key](https://www.trueelena.org/computers/howto/gpg_subkeys.html)
