# Configure Pass

Configure pass, the best password manager of the world. But it is best as long as you know little bit of linux, gpg. Otherwise you are risking your data.

pass is not installed by default, simply installed

sudo dnf install pass -y

As long as you have followed the other guides

- guide_yubikey01.md
- guide_yukikey02.md

You are ready for the next steps

## Steps to configure pass

### Initialize pass using your own password directory

You can configured your own passstore directory. By default passwords are stored in $HOME/.password-store directory.
For me it is much convienent, if use my own password directory and do backup.
Git is not something I plan to use initially. Of course, you miss the password history with it.

```bash
export PASSWORD_STORE_DIR=$HOME/Document/YourPasswordDir
# now when you init the pass, the database will be created
# $PASSWORD_STORE_DIR

pass init Yourpgid
# Password store initialized for gpgid
# As seen above, no information is given, as to
# where the database is created.
```


```bash
export MASTERKEY=$(gpg --list-keys | grep B$ | xargs echo)  # assuming your masterkey ends with B
pass init $MASTERKEY
pass git init -b main
pass git remote add origin <nameOfthePrivateRepo>
```

Now add the password and other information to pass and at the end of the day, just do not forget to sync

```bash
pass git push origin main
```

### Restore from Backup 01

This is a method I learned from the internet

```bash
git init $MASTERKEY
pass git init -b main
pass git remote add origin <nameOfthePrivateRepo>
pass git pull origin main
# Note: Optional in case you have any sync issues
pass git fetch
pass git reset --hard origin/main # this resets the current branch's head to the last commit and To discard local changes to all files, permanently:
# fetched from the remote repo (origin), discarding any local changes
```
### Restore from Backup 02

This is method I tried using git logic. <br>
Since we are storing pass database, there is <br>
no need to init pass. Because pass database, corresponding <br>
gpgid is also in your git repo. In this case, run a this single command <br>

```bash
# simple clone the repo into .password-store i.e. all your
# database will be restored into .password-store folder

git clone git@github.com:SecretRepoPath.git .password-store

# check if all went well

pass

# you should see all your password entries.
```
## Reference

[Redhat Pass Config blog](https://www.redhat.com/en/blog/management-password-store)
