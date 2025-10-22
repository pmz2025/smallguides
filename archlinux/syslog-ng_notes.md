# Notes

## Installation

Installation on ArchLinux is very simple but without their
amazing guide (wiki), i would have struggle to start
the service.

```shell
sudo systemctl enable --now syslog-ng@default.service
```

You do not need syslog-ng if you all need is local logs.
It has a very powerful filter.
Here everything is inside curl brackets and everything is closing with semicolon.

```shell
destination d_local {
    file("/var/log/messages");
};
```

There are basically four parts in the syslog-ng.conf file

- source
- destination
- filter
- options

## Sources

How you define source

```conf
source NAME {
    settings;
};

```

Under source, you can define

- file
- unix-stream
- network e.g. udp or tcp

```conf
source NAME {
    tcp(
        ip("127.0.0.1")
        port (514)
    );
};
```

## Destination

Destination is where your logs can be transferred. 
Either local using file attribute or remote

```conf
destination remote_server {
    udp(
        ip("10.0.1.100")
        port(514)
        );
};

```

## Naming convention

s - source and it is always s_
d - destination and like above, is always d_
f - filter, same as above f_

## Simple configuration

```conf
source s_system {
    system(); # refers to all logs in the system
    };
filter f_ssh {
    program("sshd");
};
destination d_ssh_logs {
    file(
        "var/log/ssh.log"
    );
};
log {
    source (s_system);
    filter (f_ssh);
    destination (d_ssh_logs);
};
```

In short, we define 
- source
- destination
- filter

and bring all together in a log. In log we do not define name.
We simply take source, destination, filter and define log.