# Just learn

Motto: Information is available on the internet, grab it and make the most of it.

I was searching today (26.08.2024), why `-c` is returning extra count and found out the below line

> The echo command includes a newline character by default

```bash
[pzare@rhel22 08:18:59 ~/Documents/smallguides]$ echo "poseidon" | wc -c
9
[pzare@rhel22 08:19:36 ~/Documents/smallguides]$ echo -n "poseidon" | wc -c
```
