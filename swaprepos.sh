#!/bin/bash

swapToUbuntu () {
    echo "Changing apt repos to Ubuntu..."
    mv /etc/apt/sources.list /etc/apt/sources.list.bak
    find /var/lib/apt/lists -type f -exec rm {} \;
    wget https://gist.githubusercontent.com/ishad0w/788555191c7037e249a439542c53e170/raw/3822ba49241e6fd851ca1c1cbcc4d7e87382f484/sources.list -O /etc/apt/sources.list
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 871920D1991BC93C
}

swapToKali () {
    echo "Changing apt repos to Kali's defaults..."
    find /var/lib/apt/lists -type f -exec rm {} \;
    mv /etc/apt/sources.list /etc/apt/ubuntu-sources.list
    mv /etc/apt/sources.list.bak /etc/apt/sources.list
}

if [ `whoami` != root ]; then
    echo Please run me as root or sudo!
    exit
fi

# --ubuntu or -u: swap to ubuntu repos
if [ "$1" = -u ] || [ "$1" = --ubuntu ]; then
    swapToUbuntu
# --kali or -k: swap back to kali repos    
elif [ "$1" = -k ] || [ "$1" = --kali ]; then
    swapToKali
else
    echo "Usage:"
    echo "./swaprepos.sh -u or --ubuntu to change to ubuntu apt repos"
    echo "./swaprepos.sh -k or --kali to change back to default kali repos"
    exit
fi

apt-get update

echo "Current sources files in /etc/apt:"
ls /etc/apt | grep sources

echo "Completed successfully!"