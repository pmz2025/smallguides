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

## References

- [sed – stream editor](https://www.cs.colostate.edu/~cs155/Spring18/Lecture/Commands3)
- [sed - delete header](https://cloufield.github.io/GWASTutorial/61_sed/#example-2-delete-headerthe-first-line)