# How to backup and restore using restic

## First check the snapshots available on your backup media

```bash
poseidon@preezahome:~|⇒  restic -r western_mypass25E4 snapshots
enter password for repository:
repository 5bf9de6e opened (version 1)
ID        Time                 Host        Tags        Paths
----------------------------------------------------------------------------------------
5841c4b7  2025-03-20 17:59:54  dell03                  /home/poseidon/Documents
987fe7e2  2025-03-20 18:00:46  dell03                  /home/poseidon/Documents
6376f6bf  2025-03-20 18:14:33  dell03                  /home/poseidon/Downloads
e229cd24  2025-03-20 18:17:20  dell03                  /home/poseidon/Pictures
6097d416  2025-04-16 10:53:43  delltb1542              /home/poseidon/Documents
fa2e0273  2025-04-16 10:54:58  delltb1542              /home/poseidon/Downloads
29de9fa2  2025-04-16 10:56:16  delltb1542              /home/poseidon/Pictures
0b9d5ba0  2025-04-16 10:56:38  delltb1542              /home/poseidon/backupkeys
22df0ec1  2025-04-16 17:46:41  delltb1542              /home/poseidon/.local/share/fonts
----------------------------------------------------------------------------------------
```
## How to backup data all important folders

```bash
restic -r western_mypass25E4 --verbose backup $HOME/Documents $HOME/Downloads $HOME/Pictures
```
## How to backup individual folders
```bash
restic -r western_mypass25E4 --verbose backup $HOME/Downloads
restic -r western_mypass25E4 --verbose backup $HOME/Pictures
```
## Check if all looks okay

```bash
poseidon@preezahome:~|⇒  restic -r western_mypass25E4 snapshots
enter password for repository:
repository 5bf9de6e opened (version 1)
ID        Time                 Host        Tags        Paths                              Size
---------------------------------------------------------------------------------------------------
5841c4b7  2025-03-20 17:59:54  dell03                  /home/poseidon/Documents

987fe7e2  2025-03-20 18:00:46  dell03                  /home/poseidon/Documents

6376f6bf  2025-03-20 18:14:33  dell03                  /home/poseidon/Downloads

e229cd24  2025-03-20 18:17:20  dell03                  /home/poseidon/Pictures

6097d416  2025-04-16 10:53:43  delltb1542              /home/poseidon/Documents

fa2e0273  2025-04-16 10:54:58  delltb1542              /home/poseidon/Downloads

29de9fa2  2025-04-16 10:56:16  delltb1542              /home/poseidon/Pictures

0b9d5ba0  2025-04-16 10:56:38  delltb1542              /home/poseidon/backupkeys

22df0ec1  2025-04-16 17:46:41  delltb1542              /home/poseidon/.local/share/fonts

3489052d  2025-04-27 15:04:03  preezahome              /home/poseidon/Documents           1.654 GiB

8999455d  2025-04-27 15:07:56  preezahome              /home/poseidon/Documents           4.923 GiB
                                                       /home/poseidon/Downloads
                                                       /home/poseidon/Pictures
---------------------------------------------------------------------------------------------------
```





## References

https://restic.readthedocs.io/en/stable/045_working_with_repos.html#listing-all-snapshots