# Playing with EOF and sed

## Scenario: I wish to create kubernetes.repo file and it has a empty line (at the end) which I wish to delete

### First create kubernetes.repo file using EOF

I'm using bash, I will update later how it works with fish

```bash
<<EOF | tee kubernetes.test
[kubernetes]
name=kubernetes repo
baseurl=https://pks.k8s.io/core:/stable://v1.33/rpm
enabled=
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable://v1.33/rpm/repodata/repomd.xml.key

EOF
```

I have with purpose created a blank line after gpgkey.

### second delete the blank line

Lets us first test if it is working as expected

```bash
head kubernetes.test | sed \$d
[kubernetes]
name=kubernetes repo
baseurl=https://pks.k8s.io/core:/stable://v1.33/rpm
enabled=
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable://v1.33/rpm/repodata/repomd.xml.key
```

As you can see the line is delete with $ being last line and we escaped `$` with \ (backslash)
now you can use `-i` flag to overwrite existing file

```bash
sed -i \$d kubernetes.test # here i denotes the original file is updated
cat kubernetes.test
[kubernetes]
name=kubernetes repo
baseurl=https://pks.k8s.io/core:/stable://v1.33/rpm
enabled=
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable://v1.33/rpm/repodata/repomd.xml.key
```

## Delete lines inside the file

It all started with verifying the checksum of ArchLinux.iso
I downloaded sha256sums.txt but it has multiple line entries and failed.
So I decided to combine my sed skills and with what i learned about
sha256sum.
So, first lets delete the lines which we do not need.
In case you wish to delete lines inside the file, 
you must know which lines to delete in advance. 

Here is an file 

```shell

wget https://archlinux.org/iso/2025.09.01/sha256sums.txt


➤ cat -n sha256sums.txt
     1	961002fab836819b599e770aa25ff02bff1697d1d051140062066a5ff47d6712  archlinux-2025.09.01-x86_64.iso
     2	961002fab836819b599e770aa25ff02bff1697d1d051140062066a5ff47d6712  archlinux-x86_64.iso
     3	29663e9fa235db2a91fd54d600b5be606160d1703b1956b3c19ed28322c17738  archlinux-bootstrap-2025.09.01-x86_64.tar.zst
     4	29663e9fa235db2a91fd54d600b5be606160d1703b1956b3c19ed28322c17738  archlinux-bootstrap-x86_64.tar.zst
# I wish to delete line 2 till 4

➤ sed '2,4 d' sha256sums.txt
961002fab836819b599e770aa25ff02bff1697d1d051140062066a5ff47d6712  archlinux-2025.09.01-x86_64.is

# lets do checksum
➤ cat $(echo sha256sums.txt) | sha256sum --check 
archlinux-2025.09.01-x86_64.iso: OK


``` 

## References

- [sed – stream editor](https://www.cs.colostate.edu/~cs155/Spring18/Lecture/Commands3)
- [sed - delete header](https://cloufield.github.io/GWASTutorial/61_sed/#example-2-delete-headerthe-first-line)