#!/bin/sh

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

checkcmd sudo

if iscmd "apt-get"; then
    echo "Installing dependencies automatically."
    sudo apt-get update
    sudo apt-get install -y --no-install-recommends fonts-firacode fonts-powerline ca-certificates neovim git vim zsh curl 
fi

checkcmd git zsh vim curl

alias dot="$(which git) --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

if [ ! -d $HOME/.dotfiles ]; then
    echo "Creating the repository in $HOME/.dotfiles"
    git init --bare $HOME/.dotfiles
    dot config status.showUntrackedFiles no
    dot remote add origin https://github.com/murar8/dotfiles
fi

echo "Pulling the repository data."
dot fetch --all
dot reset --hard origin/master
dot pull origin master

if [ ! -d $HOME/.antigen/antigen.zsh ]; then
    echo "Installing antigen."
    mkdir -p $HOME/.antigen
    curl -L git.io/antigen > $HOME/.antigen/antigen.zsh
fi

if [ ! -d $HOME/.vim/autoload/plug.vim ]; then
    echo "Installing vim-plug."
    curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +qall
fi

if [ ${SHELL} != $(which zsh) ]; then
    echo "Changing the default shell."
    sudo usermod -s $(which zsh) $USER
fi

# systemctl enable --user dotfiles.service

echo "Bootstrap completed successfully!"

zsh
