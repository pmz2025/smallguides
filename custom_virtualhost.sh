#!/bin/bash
export domainname=preetam.io
export defaultdomainName=raindev.io
export filename=$domainname.conf
export defaultfilename=virtualhost.conf
echo $filename

sed "s/$defaultdomainName/$domainname/g" $defaultfilename > $filename