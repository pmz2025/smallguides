
```shell
set -gx SVCNAME rsyslog
sudo journalctl _PID=$(systemctl show $SVCNAME --property=ExecMainPID | cut -d"=" -f2)
```

```shell
# for PID=2295
journalctl _PID=2295 -o verbose
```

```shell
# specific executable, it needs full path and in specific boot logs
~ $ sudo journalctl $(which sshd) -b
```

```shell
# If particular service is failing you can use flag f which will follow the logs and you can try to restart the service to find what is wrong or went wrong.
sudo journalctl -u -f NetworkManager
```
```shell
sudo journalctl -u sshd
# if you are using _SYSTEMD_UNIT, ensure you add .service | .socket whichever is relevant
sudo journalctl _SYSTEMD_UNIT=chronyd.service
```