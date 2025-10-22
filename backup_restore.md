# Backup and Restore Guide

To backup a directory you need to first create a repository on your HDD/Remote location.<br>
Once it is created you can start backing up your data.

My Backup repository is mounted on `~/westerndigitial`

Let me first list down the snapshots

But First let me set the password in a variable. I'm doing this using gnuPG and yubikey.<br>
As a first step, create a file and enter your password into a file e.g. myResticpasswd.secret
Set the variable using the shell of your choice. <br>
I'm using fish shell

```shell
# set the variable as mentioned below
set RESTIC_PASSWORD_COMMAND "gpg --quiet --decrypt myResticpasswd.secret.asc"

# This command decrypts the resticpasswd.secret.asc, while decrypting,
# it will ask for yubikey key and presence. But actually encrypting is
# show below
```
I'm encrypting this file using my own key using --recipient myself and as a best
practice signing it as well.

```shell
gpg --encrypt --sign --recipient repolevedp@gmail.com --armor myResticpasswd.secret
# file with name myResticpasswd.secret.asc is created.
```
You should ideally backup and then delete the original file.

```shell
# delete the original file
rm myResticpasswd.secret
```

As you can see below, I'm no where entering my paraphrase required for <br>
restic. This command will decrypt the password <br>
and send it to restic to list snapshots.


```shell
restic --password-command $RESTIC_PASSWORD_COMMAND -r ~/westerndigitial/ snapshots
```

**_OUTput_**
```v
gpg: Signature made Thu Oct  9 13:01:53 2025 CEST
gpg:                using EDDSA key 9ECBC32B558C3E75A6BE989DA82572C55C8846C1
gpg: Good signature from "Preetam Zare <repolevedp@gmail.com>" [ultimate]
repository 5bf9de6e opened (version 1)
```

**OUTput**
```shell
restic --password-command $RESTIC_PASSWORD_COMMAND -r westerndigitial/ snapshots
repository 5bf9de6e opened (version 1)
ID        Time    Host        Tags        Paths     Size

# data is redacted, but the most important part in this OUTput
# is under Paths. Lets try to restore 

```

SNApshot listing provides following important information

- snapshot id
- date and time of the backup
- data which was backed up and size

SNApshot id helps you list down what is inside specific snapshot using the following command.

```shell
snapshotid=e47c137b
restic --password-command $RESTIC_PASSWORD_COMMAND -r westerndigitial/ ls $snapshotid
```

## REStoring data

For restoring data, we need snapshot ID and target directory. <br>
As mentioned above, the most important is Paths.<br>
In the below command, I have selected `backup_data` as the target <br>
So, all data will restore in this target but the directory <br>
structure would be maintained. e.g. if you are restoring /home/YOUrname/Documents <br>
it will restore backup_data/home/YOUrname/Documents

```shell
restic --password-command $RESTIC_PASSWORD_COMMAND\
-r westerndigitial \ estore --verbose --target \
backup_data 873857a9
``` 

## BACkup data

To backup data in Document directory, use the following, please note you will need repo password
```shell
restic --password-command $RESTIC_PASSWORD_COMMAND \
-r westerndigitial --verbose \
backup ~/Documents/
```

## Change the paraphrase or change the repo password

In restic it is referred as key and this key is per repo. <br>
You run list key command as show below, you get key assoicated <br>
with the repo.

```shell
↪ restic -r ~/westerndigitial/ key list
enter password for repository: 
repository 5bf9de6e opened (version 1)
 ID        User      Host    Created
------------------------------------------------
*f46f37fb  poseidon  dell03  2025-03-20 17:58:34
------------------------------------------------
``` 

## References

[Working with repositories](https://restic.readthedocs.io/en/stable/045_working_with_repos.html)

[Back up data](https://restic.readthedocs.io/en/stable/040_backup.html)