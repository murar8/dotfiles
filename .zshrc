ANTIGEN_PATH=$HOME/.antigen

if [ ! -f $ANTIGEN_PATH/antigen.zsh ]; then
    echo "Installing antigen!..."
    mkdir -p $ANTIGEN_PATH
    curl -sL git.io/antigen > $ANTIGEN_PATH/antigen.zsh
fi

# oh-my-zsh
DISABLE_MAGIC_FUNCTIONS=true
COMPLETION_WAITING_DOTS="true"

# zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=true

source $ANTIGEN_PATH/antigen.zsh

antigen use oh-my-zsh
antigen bundle git
antigen bundle colored-man-pages

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

antigen bundle denysdovhan/spaceship-prompt

antigen apply

# User configuration

setopt aliases

alias dot="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

function dotsync {
    if [[ -z $(dot status --porcelain) ]]; then return 0; fi

    dot add -u
    dot commit -m "changes from $(uname -n) on $(date)."

    dot fetch origin master

    dot merge --ff --squash origin/master

    if [ $? != 0 ]; then return 1; fi

    dot push origin master
}

