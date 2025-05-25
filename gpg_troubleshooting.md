# Troubleshooting steps

Here On Fedora was getting the following error

```bash
poseidon@preezahome:~$ gpg -vvv --card-status
gpg: using character set 'utf-8'
gpg: enabled compatibility flags:
gpg: selecting card failed: No such device
gpg: OpenPGP card not available: No such device
```

### check the status of pcscd (pcscd.service - PC/SC Smart Card Daemon)

`systemctl status pcscd`

### Restart the service

`systemctl restart pcscd`

### Finally, kill and restart the service

```bash
pkill scdaemon
systemctl restart pcscd
gpg --card-status
```

### When you see gpg: waiting for lock (held by [process_id])

search for a file inside a gpg directory which has extention .lock and delete it.

```bash
find ~/.gpg -name \*lock -exec rm {} \;
```
