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

antigen theme denysdovhan/spaceship-prompt

antigen apply

# User configuration

alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias dot-sync='https://raw.githubusercontent.com/simonthum/git-sync/master/git-sync'
