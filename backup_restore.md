# Backup and Restore Guide

To backup a directory you need to first create a repository on your HDD/Remote location.
Once it is created you can start backing up your data.

Here is the sample command.

My Backup repository is mounted on `/home/xpreetam/western_mypass25E4`

Let me first list down the snapshots


restic -r western_mypass25E4/ snapshots

Snapshot listing provides following important information

- snapshot id
- date and time of the backup
- data which was backed up and size

snapshot id helps you list down what is inside specific snapshot using the following command.

```shell
snapshotid=e47c137b
restic -r western_mypass25E4/ ls $snapshotid
```
To backup data in Document directory, use the following, please note you will need repo password

`restic -r western_mypass25E4 --verbose backup ~/Documents/`

## References

[Working with repositories](https://restic.readthedocs.io/en/stable/045_working_with_repos.html)

[Back up data](https://restic.readthedocs.io/en/stable/040_backup.html)