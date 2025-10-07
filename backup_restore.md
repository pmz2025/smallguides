# Backup and Restore Guide

To backup a directory you need to first create a repository on your HDD/Remote location.
Once it is created you can start backing up your data.

Here is the sample command.

My Backup repository is mounted on `/home/xpreetam/western_mypass25E4`

Let me first list down the snapshots

```shell
restic -r western_mypass25E4/ snapshots
```
**OUTput**
```shell
restic -r westerndigitial/ snapshots
enter password for repository: 
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
restic -r western_mypass25E4/ ls $snapshotid
```

## REStoring data

For restoring data, we need snapshot ID and target directory. <br>
As mentioned above, the most important is Paths.<br>
In the below command, I have selected `backup_data` as the target <br>
So, all data will restore in this target but the directory <br>
structure would be maintained. e.g. if you are restoring /home/YOUrname/Documents <br>
it will restore backup_data/home/YOUrname/Documents

```shell
restic -r westerndigitial restore --verbose --target backup_data 873857a9
``` 

## BACkup data

To backup data in Document directory, use the following, please note you will need repo password

`restic -r western_mypass25E4 --verbose backup ~/Documents/`

## References

[Working with repositories](https://restic.readthedocs.io/en/stable/045_working_with_repos.html)

[Back up data](https://restic.readthedocs.io/en/stable/040_backup.html)