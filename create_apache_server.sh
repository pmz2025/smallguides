#!/bin/bash
export domainname=preetam.io
export filename=$domainname.conf
# create placeholder directory
mkdir -pv web_certificates

# change into placeholder directory
cd

# create private key
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 --out server.key

# create configuration file and save it as ssl.cnf

# create csr
openssl req -new -key server.key -out server.csr -config ssl.cnf

# self signed your certificate
openssl req -x509 -key server.key -in server.csr -out server.crt -addext "subjectAltName=DNS:depot.raindev.io" -copy_extensions copyall

# copy certificates
sudo cp -v server.crt /etc/pki/tls/certs/
sudo cp -v server.key /etc/pki/tls/certs/

# Install apache and ssl mod

sudo dnf install httpd mod_ssl -y

# Copy virtualhost.conf file

sudo chown root:root
sudo cp -v $filename /etc/httpd/conf.d/

# test apache configuration
sudo apachectl configtest

# start httpd
sudo systemctl enable --now httpd

# check
curl -k https://depot.raindev.io