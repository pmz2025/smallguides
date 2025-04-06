# Notes on Github

## What is a pull request?

**Collaboration happens on a pull request.** The pull request shows the changes in your branch to other people and allows people to accept, reject, or suggest additional changes to your branch. 
In a side by side comparison, this pull request is going to keep the changes you just made on your branch and propose applying them to the main project branch.

> A merge is also a kind of commit!

Once your branch has been merged, you don't need it anymore.

Sometimes it can happen if you git diff, you will 'ESC' character. This can be disabled using 'R' in LESS

e.g.

`export LESS='-iRX'`

i - case insenstive search

R - I do not know

X - to avoid clearing screen, after you quit e.g. the man pages

or git specific option 

`git config core.pager 'less -R'`  My preferred choice

Learned this first time. You can rename file directly using git

`git mv oldname newname`

`git log --oneline`

```bash
$ git log --oneline
ddc87ae (HEAD -> master) delete praise.txt
36d2cda renamed message.txt
0dca126 corrected spell
```
`git log --graph`

```bash
git log --graph
* commit ddc87ae9a85ae1a515db767af0dcc4ab0b402cf8 (HEAD -> master)
| Author: Full Rep <emptyrepo@gmail.com>
| Date:   Sat Apr 5 18:44:44 2025 +0200
| 
|     delete praise.txt
| 
* commit 36d2cda8d9dc4b2504a04acf96f58cc0129b6343
| Author: Full Rep <emptyrepo@gmail.com>
| Date:   Sat Apr 5 18:37:36 2025 +0200
| 
|     renamed message.txt
| 
* commit 0dca1261c96f8d3747e801c83bad3e8a1974bc3f
  Author: Full Rep <emptyrepo@gmail.com>
  Date:   Sat Apr 5 18:34:51 2025 +0200
  
      corrected spell
```
`git log --graph --oneline`

```bash
delltb1542:empty_rep:% git log --graph --oneline                                                                   <master ✗>
* ddc87ae (HEAD -> master) delete praise.txt
* 36d2cda renamed message.txt
* 0dca126 corrected spell
```

## Date: 06.04.2025

You can use bash notation to exclude or include files in .gitignore

[B/b]in/ 

The above notation exclude directory bin (case included)