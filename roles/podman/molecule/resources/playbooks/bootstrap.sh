#!/bin/bash

if [ "$(whoami)" != "root" ]; then
    sudo su -s "$0"
    exit
fi

if [ $(command -v apt-get) ]; then
    apt-get update
    apt-get install -y python sudo bash ca-certificates
    apt-get clean
elif [ $(command -v dnf) ]; then
    dnf makecache
    dnf --assumeyes install python3 sudo python3-devel python3-dnf bash
    dnf clean all
elif [ $(command -v yum) ]; then
    yum makecache fast
    yum install -y python sudo yum-plugin-ovl bash
    sed -i 's/plugins=0/plugins=1/g' /etc/yum.conf
    yum clean all
elif [ $(command -v zypper) ]; then
    zypper refresh
    zypper install -y python sudo bash python-xml
    zypper clean -a
elif [ $(command -v apk) ]; then
    apk update
    apk add --no-cache python sudo bash ca-certificates
fi
