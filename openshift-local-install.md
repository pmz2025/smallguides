
```bash
export LOCATION=$HOME/local/bin
export FILEBITS=crc-linux-amd64.tar.xz
mkdir -pv $LOCATION
cd $HOME/Downloads
export CRCDIR=$(tar -tf $FILEBITS | grep -i amd64/$ | xargs -i -d / sh -c 'CRCDIR="{}"; echo -n "$CRCDIR"')
tar -xvf $FILEBITS
cp -v $CRCDIR/crc $LOCATION
echo export PATH=$LOCATION:$PATH >> $HOME/.bashrc
source $HOME/.bashrc
crc setup
```

# set memory to 32 GiB
```bash
MEM=32256
crc config set memory $MEM
```

```bash
# set cpu to 14
CPUCOUNT=24
crc config set cpus $CPUCOUNT
```

```bash
# set disk size in GiB (default 31 GiB)
DISKSIZE=131
crc config set disk-size 131
```

```bash
# enable monitoring
crc config set enable-cluster-monitoring true
```

```bash
# Set Network mode to system
crc config get network-mode
Configuration property 'network-mode' is not set. Default value 'user' is used
crc config set network-mode system && crc cleanup && crc setup
```

```bash
poseidon@satorni:~/Downloads$ crc config view
- consent-telemetry                     : yes
- cpus                                  : 14
- disk-size                             : 131
- enable-cluster-monitoring             : true
- memory                                : 32256
- network-mode                          : system
poseidon@satorni:~/Downloads$ 
```

```bash
# Finally start, ensure you give path to the secret
crc start -p $HOME/Downloads/pull-secret 
```

### Post Installation

#### Add path
echo PATH=$HOME/.crc/bin/oc:$PATH >> $HOME/.bashrc

#### Add auto completion for bash

oc complete bash > oc_bash_completion
sudo chown root:root oc_bash_completion
sudo cp -v oc_bash_completion /etc/bash_completion.d/
logout

#### Add alias/abbr

abbr --add ocdev 'oc login -u developer -p developer https://api.crc.testing:6443'

abbr --dd ockadm 'oc login -u kubeadmin -p BnXhT-ychem-Ry5Iz-GYDXj https://api.crc.testing:6443'

## Install and configuring haproxy

```bash
sudo dnf -y install haproxy policycoreutils-python-utils
sudo firewall-cmd --add-port=80/tcp --permanent 
sudo firewall-cmd --add-port=6443/tcp --permanent 
sudo firewall-cmd --add-port=443/tcp --permanent 
sudo firewall-cmd reload
sudo firewall-cmd --reload 
sudo firewall-cmd get-ports
sudo firewall-cmd --get-ports
sudo firewall-cmd --list-ports
sudo semanage port -a -t http_port_t -p tcp 6443
CRCIP=$(crc ip)

# make backup of ha proxy

sudo cp -v /etc/haproxy/haproxy.cfg{,.$(date +%F)}
sudo vim /etc/haproxy/haproxy.cfg

# delete all contents
# and paste the following content

global
        debug
        log 127.0.0.1 local0

defaults
        log global
        mode http
        timeout connect 0
        timeout client 0
        timeout server 0

listen  apps-http
        bind IP_OF_SERVER:80
        option tcplog
        mode tcp
        server webserver1 IP_OF_CRC:80 check

listen  apps-https
        bind IP_OF_SERVER:443
        option tcplog
        mode tcp
        option ssl-hello-chk
        server webserver1 IP_OF_CRC:443 check

listen  api
        bind IP_OF_SERVER:6443
        option tcplog
        mode tcp
        option ssl-hello-chk
        server webserver1 IP_OF_CRC:6443 check

# finally verify haproxy file

haproxy -f /etc/haproxy/haproxy.cfg -c

# enable and restart the service

sudo systemctl enable --now haproxy

# add the following to your etc/hosts
192.168.50.126   api.crc.testing canary-openshift-ingress-canary.apps-crc.testing console-openshift-console.apps-crc.testing default-route-openshift-image-registry.apps-crc.testing downloads-openshift-console.apps-crc.testing host.crc.testing oauth-openshift.apps-crc.testing application-test-intro-navigate.apps-crc.testing

```
