#!/usr/bin/env bash

set -e

iscmd() { 
    command -v $1 > /dev/null 
}

checkcmd() {
    for cmd in $@; do
        if ! iscmd $cmd;then
            echo "Error: could not find command $cmd."
            exit 1
        fi
    done
}

DISTRO=$(lsb_release -si)

if [ $DISTRO != "Ubuntu" ] && [ $DISTRO != "Debian" ]; then
    2>&1 echo "Error: This script can only run on debian based linux distributions."
    exit 1
fi

checkcmd sudo wget apt-get

echo "Installing dependencies."
sudo apt-get update
sudo apt-get install -y --no-install-recommends fonts-firacode fonts-powerline ca-certificates neovim git vim zsh curl 

source <(wget -qO- https://raw.githubusercontent.com/murar8/dotfiles/master/.bootstrap/bootstrap-common.sh)
