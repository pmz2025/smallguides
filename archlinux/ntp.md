# NTP

NTP is default configured in ArchLinux but it is not using chronyd
instead systemd-timesyncd
the file is located at /etc/systemd/timesyncd.d

And here the following command works.

timedatectl timesync-status

timedatectl show-timesync