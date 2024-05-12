# Installing ansible

Though this is bit straight forward but i think it is worth documenting, so that less time is invested in future

## Installing Ansible on Rocky

[Great resource is available here](https://docs.rockylinux.org/books/learning_ansible/01-basic/)

```bash
# step:01 install EPEL
sudo dnf install epel-release

# step:02 install ansible
sudo dnf install ansible
```

### Installing ansible-lint

you need ansible-lint for sure but for that you need pip. Here is another guide

[Install ansible-lint](https://www.atlantic.net/vps-hosting/how-to-install-and-use-pip-python-package-manager-on-rocky-linux/)
But in short, here is the code

```bash
# first find the python version

python --version
Python 3.9.18

# install right pip
sudo dnf install python3.9-pip -y

# now install ansible lint
pip3 install ansible-lint

# may be optionally install py
pip3 install PyVMomi
```