# Provisioning RHEL automatically

Use vagrant file in this folder `Vagrantfile` it is main function and it is to read the environmental variables and pass it to the script defined under s.path.

## Step:01
create a folder for your VM.

```shell
set -gx VMFOLDERNAME encserver
mkdir -pv \$VMFOLDERNAME/scripts
cd \$VMFOLDERNAME
cp -v /home/letsdodev/gitrepos/smallguides/vagrant_conf/{Vagrantfile,postinstall.sh} .
mv -v postinstall.sh scripts
```

Environmental variables must be defined in your current shell

```shell
# this is fish shell format for exporting environmental variables
set -gx SUB_USERNAME redhatsubscriptionemailaddress
set -gx SUB_PASSWORD redhatsubscriptionpassword
```

## Step:02
create a postinstall.sh script or reuse postinstall.sh in this folder.

1. create a folder scripts
    - `mkdir -v scripts`

2. Copy postinstall.sh into scripts folder
    - `cp -v postinstall.sh scripts`

## Step:03
Run the following command

`vagrant up`


>Note: This is registrating your instance with RedHat Subscription. If you destroy the machine, you must manually unregister from the RedHat Subscription portal.
