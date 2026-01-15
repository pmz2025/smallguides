# Moving Passwords via clipboard between pass and 1Password

Why: Well I do not wish to install 1password on all machines/enduser devices
and i do not want to paste the password or write the password in any file.
Only clipboard it and paste it directly into 1Password

1. COPy the password  into clipboard
```shell 
pass -c pathOfthePasswd
```
This will copy the password in clipboard (wl-copy).<br>

2. SET the password into variable as

```shell
set secretpass $(wl-paste)
echo $secretpass | gpg --encrypt --recipient $KEYID --armor --output secretpass.gpg.asc
```

3. EMAil secretpass.gpg.asc to yourself.<br>
4. Download it on a computer where 1password is installed and decrypt it using the following command.
```
gpg --decrypt secretpass.gpg.asc | wl-copy
```
5. NOW, simply using ctrl + p to paste your password into 1Password.

## Copy from 1Password to pass

1. copy the password from 1Password in a clipboard
2. echo $(clippaste) | gpg --encrypt --armor --recipient <name> --out nameofthefile.asc
3. email this file
4. decrpyt the file using the following command

```shell
set awsin $(gpg --decrypt --quiet Downloads/aws_in.asc)

pass insert test/sampleentry
# enter test123 and test123
pass edit test/sampleentry

# paste the password from the clipboard

```
