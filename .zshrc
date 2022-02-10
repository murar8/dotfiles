# .zshrc
#
# Author: Lorenzo Murarotto <lnzmrr@gmail.com>

# oh-my-zsh

DISABLE_MAGIC_FUNCTIONS=true

# spaceship-prompt

SPACESHIP_PROMPT_ADD_NEWLINE=false
# SPACESHIP_CHAR_SYMBOL="~ "
# SPACESHIP_CHAR_SYMBOL_ROOT="# "

# zsh-autosuggestions

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=true

# zsh-syntax-highlighting

ZSH_HIGHLIGHT_MAXLENGTH=20
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# antigen installation

ANTIGEN_PATH=$HOME/.antigen

if [ ! -f $ANTIGEN_PATH/antigen.zsh ]; then
    echo "Installing antigen!..."
    mkdir -p $ANTIGEN_PATH
    curl -sL git.io/antigen >$ANTIGEN_PATH/antigen.zsh
fi

source $ANTIGEN_PATH/antigen.zsh

antigen use oh-my-zsh
antigen bundle git
antigen bundle colored-man-pages
antigen bundle docker
antigen bundle docker-compose

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

antigen apply

# environment

if command -v code &>/dev/null && ([ "$TERM_PROGRAM" = 'vscode' ] || [ -t 0 ]); then
    export EDITOR="$(which code) -w"
elif command -v nvim &>/dev/null; then
    export EDITOR=nvim
elif command -v vim &>/dev/null; then
    export EDITOR=vim
fi

# dotfile status

setopt aliases

alias dot="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

function dot-status {
    RED="\e[0;31m"
    YELLOW="\e[0;33m"
    PURPLE="\e[0;35m"
    NC="\e[0m"

    UPSTREAM="origin/master"
    LOCAL=$(dot rev-parse @)
    REMOTE=$(dot rev-parse "$UPSTREAM")
    BASE=$(dot merge-base @ "$UPSTREAM")

    if [ "$LOCAL" = "$REMOTE" ]; then
        return
    fi

    if [ "$LOCAL" = "$BASE" ]; then
        echo "${YELLOW}Warning: Your configuration files are outdated.${NC}\n"
    elif [ "$REMOTE" = "$BASE" ]; then
        echo "${PURPLE}Warning: Remember to push Your committed changes to the remote branch.${NC}\n"
    else
        echo "${RED}Warning: Local and remote have diverged.${NC}\n"
    fi
}

alias timeout="timeout " # Make the shell parse expand all the aliases
timeout 1 dot fetch &>/dev/null
unalias timeout
dot-status

# starship

STARSHIP_PATH=$HOME/.local/bin

export PATH=$PATH:$STARSHIP_PATH

if [ ! -f $STARSHIP_PATH/starship ]; then
    echo "Installing starship!..."
    mkdir -p $STARSHIP_PATH
    curl -fsSL https://starship.rs/install.sh | sh -s -- --yes --bin-dir $STARSHIP_PATH >/dev/null
fi

eval "$($STARSHIP_PATH/starship init zsh)"
