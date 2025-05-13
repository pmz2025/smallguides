
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
