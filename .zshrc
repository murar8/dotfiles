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

# starship

STARSHIP_PATH=$HOME/.local/bin

export PATH=$PATH:$STARSHIP_PATH

if [ ! -f $STARSHIP_PATH/starship ]; then
    echo "Installing starship!..."
    mkdir -p $STARSHIP_PATH
    curl -fsSL https://starship.rs/install.sh | bash -s -- --yes --bin-dir $STARSHIP_PATH >/dev/null
fi

eval "$($STARSHIP_PATH/starship init zsh)"

# dotfiles

setopt aliases

alias dot="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

function check-status {
    RED="\033[0;31m"
    YELLOW="\033[0;33m"
    PURPLE="\033[0;35m"
    NC="\033[0m"

    UPSTREAM=${1:-'@{u}'}
    LOCAL=$(dot rev-parse @)
    REMOTE=$(dot rev-parse "$UPSTREAM")
    BASE=$(dot merge-base @ "$UPSTREAM")

    if [ $LOCAL = $BASE ]; then
        echo "${YELLOW}Warning: Your configuration files are outdated.${NC}"
    elif [ $REMOTE = $BASE ]; then
        echo "${PURPLE}Warning: Remember to push Your committed changes files to the remote branch.${NC}"
    elif [ $LOCAL != $REMOTE ]; then
        echo "${RED}Warning: Local and remote have diverged.${NC}"
    fi
}

alias timeout='timeout 1 '
timeout dot remote update &> /dev/null && check-status
