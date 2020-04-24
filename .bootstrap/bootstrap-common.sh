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

checkcmd sudo git zsh vim curl

if [ ! -d $HOME/.dotfiles ]; then
    echo "Creating repository in $HOME/.dotfiles."
    git init --bare $HOME/.dotfiles
    command -v dot
    dot config status.showUntrackedFiles no
    dot remote add origin https://github.com/murar8/dotfiles
fi

if [ ! -d $HOME/.antigen/antigen.zsh ]; then
    echo "Installing antigen."
    mkdir -p $HOME/.antigen
    curl -L git.io/antigen > $HOME/.antigen/antigen.zsh
fi

if [ ! -d $HOME/.vim/autoload/plug.vim ]; then
    echo "Installing vim-plug."
    curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ ${SHELL} != $(which zsh) ]; then
    echo "Changing the default shell."
    sudo usermod -s $(which zsh) $(whoami)
fi

echo "Pulling the repository data."
dot fetch --all
dot reset --hard origin/master
dot pull origin master

echo "Installing vim plugins."
vim +PlugInstall +qall

echo "Bootstrap completed successfully."

$(which zsh)
