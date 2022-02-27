# .bashrc
#
# Author: Lorenzo Murarotto <lnzmrr@gmail.com>

# stop logging of repeated identical commands

export HISTCONTROL=ignoredups

# config

STARSHIP_PATH=$HOME/.local/bin

# aliases

alias dot="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# completion

if [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
fi

if [[ $PS1 && -f /usr/share/bash-completion/completions/git ]]; then
    source /usr/share/bash-completion/completions/git
    complete -F _git dot
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
