# Configure Pass

Configure pass, the best password manager of the world. But it is best as long as you know little bit of linux, gpg. Otherwise you are risking your data.

pass is not installed by default, simply installed

sudo dnf install pass -y

As long as you have followed the other guides

- guide_yubikey01.md
- guide_yukikey02.md

You are ready for the next steps

## Steps to configure pass

### Initialize pass

```bash
export MASTERKEY=$(gpg --list-keys | grep B$ | xargs echo)  `assuming your masterkey ends with B`
pass init $MASTERKEY
pass git init -b main
pass git remote add origin <nameOfthePrivateRepo>
```

Now add the password and other information to pass and at the end of the day, just do not forget to sync

`pass git push origin main`

### Restore from Backup

```bash
git init $MASTERKEY
pass git init -b main
pass git remote add origin <nameOfthePrivateRepo>
pass git pull origin main
>Note: Optional in case you have any sync issues
pass git fetch
pass git reset --hard origin/main # this resets the current branch's head to the last commit and To discard local changes to all files, permanently:
# fetched from the remote repo (origin), discarding any local changes
```

## Reference

[Redhat Pass Config blog](https://www.redhat.com/en/blog/management-password-store)
