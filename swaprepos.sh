#!/bin/bash

swapToUbuntu () {
    echo "Changing apt repos to Ubuntu..."
    mv ./test-files/sources.list ./test-files/sources.list.bak
    # find /var/lib/apt/lists -type f -exec rm {} \;
    wget https://gist.githubusercontent.com/ishad0w/788555191c7037e249a439542c53e170/raw/3822ba49241e6fd851ca1c1cbcc4d7e87382f484/sources.list -O ./test-files/sources.list
    # apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
    # apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 871920D1991BC93C
}

swapToKali () {
    echo "Changing apt repos to Kali's defaults..."
    # find /var/lib/apt/lists -type f -exec rm {} \;
    mv ./test-files/sources.list ./test-files/ubuntu-sources.list
    mv ./test-files/sources.list.bak ./test-files/sources.list
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
    echo Usage: add later
fi

# apt-get update