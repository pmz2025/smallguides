# Enable automatic updates

Here on Fedora how to enable automatic updates

You need a dnf5 plugin for it.

1. Install DNF automatic plugin.

```shell
# search the plugin using
sudo dnf info dnf5-plugin-automatic

# install the plugin
sudo dnf install dnf5-plugin-automatic
```

2. REAd the man pages for dnf5-plugin-automatic.

```fish
# create a file automatic.conf under /etc/dnf/automatic.conf
# which has following entries

[commands]
apply_updates = yes
download_updates = yes
upgrade_type = security
reboot = when-needed
[emitters]
emit_via = motd

```

since I'm applying only security related updates <br/>
i have simply choose to reboot the system. <br/>
Of course on production server, it will never be activated <br/>
`emit_via` creates a file inside /etc/motd.d/dnf5-automatic