# Just learn

Motto: Information is available on the internet, grab it and make the most of it.

I was searching today (26.08.2024), why `-c` is returning extra count and found out the below line

> The echo command includes a newline character by default

```bash
[pzare@rhel22 08:18:59 ~/Documents/smallguides]$ echo "poseidon" | wc -c
9
[pzare@rhel22 08:19:36 ~/Documents/smallguides]$ echo -n "poseidon" | wc -c
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

