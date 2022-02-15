# .bashrc
#
# Author: Lorenzo Murarotto <lnzmrr@gmail.com>

# config

STARSHIP_PATH=$HOME/.local/bin

# editor

if command -v code &>/dev/null && ([ "$TERM_PROGRAM" = 'vscode' ] || [ -t 0 ]); then
    export EDITOR="$(which code) -w"
elif command -v nvim &>/dev/null; then
    export EDITOR="$(which nvim) -w"
elif command -v vim &>/dev/null; then
    export EDITOR="$(which vim) -w"
fi

# aliases

alias dot="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# starship

if [ ! -f $STARSHIP_PATH/starship ]; then
    echo "Installing starship!..."
    mkdir -p $STARSHIP_PATH
    curl -fsSL https://starship.rs/install.sh | sh -s -- --yes --bin-dir $STARSHIP_PATH >/dev/null
fi

eval "$($STARSHIP_PATH/starship init bash)"
