#!/usr/bin/env bash

echo "Starting bootstrap procedure."

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

dot() {
    $(which git) --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

checkcmd git

if [ ! -d $HOME/.dotfiles ]; then
    echo "Creating bare repository in $HOME/.dotfiles."

    git init --bare $HOME/.dotfiles
    dot config status.showUntrackedFiles no
    dot remote add origin https://github.com/murar8/dotfiles
fi

echo "Pulling files from upstream."

dot fetch --all
dot reset --hard origin/master
dot pull origin master

if [ -z "$PS1" ] && [ $SHELL != $(which zsh) ]; then
    chsh -s $(which zsh)
else
    echo "Please remember to set your default shell to zsh!"
    echo
fi

echo "Bootstrap procedure completed successfully."
