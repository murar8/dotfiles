# .bashrc
#
# Author: Lorenzo Murarotto <lnzmrr@gmail.com>

# if not running interactively don't do anything

[ -z "$PS1" ] && return

# stop logging of repeated identical commands

export HISTCONTROL=ignoredups

# config

STARSHIP_PATH=$HOME/.local/bin

# aliases

alias dot="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# completion

if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
fi

if [[ -f /usr/share/bash-completion/completions/git ]]; then
    source /usr/share/bash-completion/completions/git
    __git_complete dot git
fi

# history completion

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# editor

if command -v code &>/dev/null && ([ "$TERM_PROGRAM" = 'vscode' ] || [ -t 0 ]); then
    export EDITOR="$(which code) -w"
elif command -v nvim &>/dev/null; then
    export EDITOR="$(which nvim)"
elif command -v vim &>/dev/null; then
    export EDITOR="$(which vim)"
fi

# starship

if [ ! -f $STARSHIP_PATH/starship ]; then
    echo "Installing starship!..."
    mkdir -p $STARSHIP_PATH
    curl -fsSL https://starship.rs/install.sh | sh -s -- --yes --bin-dir $STARSHIP_PATH >/dev/null
fi

eval "$($STARSHIP_PATH/starship init bash)"

# host specific configuration

if [[ -f $HOME/.bashrc.host ]]; then
    source $HOME/.bashrc.host
fi
