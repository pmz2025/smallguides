# All about Journalctl

The journalctl file is located under /etc/systemd/journald.conf

Mastering journalctl is must for troubleshooting.

journalctl -xb

- flag -x stands for providing detail message where applicable
-b flag to parse all boot

But check if the logs are persistent using

journalctl --list-boots

If particular service is failing you can simply use

journalctl -u -f NetworkManager 

- flag f will follow the logs and you can try to restart the service
  to find what is wrong or went wrong.

## DMSEG

dmesg is another handy tool.

you can clear the dmseg logs (ring) using

dmesg -C

## Check for failed units

systemctl --failed

systemd-analyze critical-chain

systemd-analyze blame