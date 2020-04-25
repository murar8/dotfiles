#!/usr/bin/env bash

if [ $# -lt 3 ]; then 
    echo "Error: Not enough arguments." 
    echo "Usage: bootstrap-docker.sh <username> <user-uid> <user-gid>"
    exit 1 
fi

USERNAME=$1
USER_UID=$2
USER_GID=$3

DEBIAN_FRONTEND=noninteractive

apt-get upgrade -y
apt-get install -y --no-install-recommends \
    zsh \
    sudo \
    locales \
    curl \
    ca-certificates \
    neovim \
    git 

groupadd --gid $USER_GID $USERNAME 
useradd -s $(which zsh) --uid $USER_UID --gid $USER_GID -m $USERNAME 

echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME 
chmod 0440 /etc/sudoers.d/$USERNAME

locale-gen en_US.UTF-8

DEBIAN_FRONTEND=dialog

SETUP_SCRIPT_URL="https://raw.githubusercontent.com/murar8/dotfiles/master/.bootstrap/bootstrap.sh"

curl -o /tmp/bootstrap.sh ${SETUP_SCRIPT_URL} 
chmod +x /tmp/bootstrap.sh 

su - $USERNAME -c 'bash /tmp/bootstrap.sh'
