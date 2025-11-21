# Just learn

Motto: Information is available on the internet, grab it and make the most of it.

I was searching today (26.08.2024), why `-c` is returning extra count and found out the below line

> The echo command includes a newline character by default

```bash
echo "poseidon" | wc -c
# OUTput #
9
# OUTput #
echo -n "poseidon" | wc -c
# OUTput, changes from 9 to 8 #
8 
# OUTput #
```

## SPEcial permissions in short

### 4775
4775 - special permission on file e.g. passwd
```shell
ls -l /usr/bin/passwd
```
**_OUTput_**
```v
-rwsr-xr-x 1 root root 80856 Jun 27 09:35 /usr/bin/passwd*
```

### 2775
2775 - special permission on folder, where whoever creates the file, group ownership remains with the group.

### 1775
1775 - special permission on folder, where person who creates file is the own e.g. /tmp directory

```shell
ls -ld /tmp/
```
**_OUTput_**
```v
drwxrwxrwt 17 root root 380 Oct  6 15:35 /tmp/
```

## HOW to kill session administratively?

You need process id of the user.

```shell
who -u # will provide pid which we need to kill.

~ $ who -u
openssluser pts/0        2025-11-10 10:48   .          7834 (192.168.56.1)
openssluser pts/1        2025-11-10 10:48   .          7863 (192.168.56.1)

# here we are interested in 7863, because i'm logged in on pts/0 as shown.
~ $ ps 

# OUTput #
    PID TTY          TIME CMD
   7849 pts/0    00:00:00 fish
   7922 pts/0    00:00:00 ps
# OUTput #

kill 7863
```

Below is the Process tree of 7863, you will see 
7863 is running sshd session.
And it is parent session.
You can kill 7863

```shell
~ $ pstree -ags 7863
systemd,1 text --switched-root --system --deserialize 31
  └─sshd,982
      └─sshd,7863
          └─sshd,7863
              └─fish,7867

# who is owning 7863 is seen below.
~ $ ps -a 7863
    PID TTY      STAT   TIME COMMAND
   7863 ?        Ss     0:00 sshd: openssluser [priv]
   8047 pts/0    R+     0:00 ps -a 786

```
