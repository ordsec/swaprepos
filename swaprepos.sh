#!/bin/bash

swapToUbuntu () {
    # if the back-up file already exists,
    # repos have already been swapped
    if [ -e /etc/apt/sources.list.bak ]; then
        echo "Looks like you have already swapped your repos to Ubuntu's!"
        echo "Try using the -k flag to change back to Kali repos."
        exit
    fi

    echo "Changing apt repos to Ubuntu..."
    mv /etc/apt/sources.list /etc/apt/sources.list.bak
    find /var/lib/apt/lists -type f -exec rm {} \;
    # only download ubuntu sources and register keys
    # if the ubuntu-sources.list file isn't already there
    # (i.e. first time running the script)
    if [ -e /etc/apt/ubuntu-sources.list ]; then
        mv /etc/apt/ubuntu-sources.list /etc/apt/sources.list
    else
        wget https://gist.githubusercontent.com/ishad0w/788555191c7037e249a439542c53e170/raw/3822ba49241e6fd851ca1c1cbcc4d7e87382f484/sources.list -O /etc/apt/sources.list
        apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
        apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 871920D1991BC93C
    fi
}

swapToKali () {
    # if the back-up file isn't there, 
    # we've already changed back to Kali repos
    if [ ! -e /etc/apt/sources.list.bak ]; then
        echo "Have you already changed the repos back to Kali?"
        echo "If running for the first time, use the -u or --ubuntu flag."
        exit
    fi

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