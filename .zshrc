# .zshrc
#
# Author: Lorenzo Murarotto <lnzmrr@gmail.com>

# user configuration

setopt aliases
alias dot="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# dotfiles installation

REPO_URL=https://github.com/murar8/dotfiles
REPO_DIR=$HOME/.dotfiles

if [ ! -d $REPO_DIR ]; then
    echo "Creating dotfiles repository!..."

    git init --bare $REPO_DIR
    dot config status.showUntrackedFiles no
    dot remote add origin $REPO_URL
    dot fetch --all
    dot pull origin master
fi

# oh-my-zsh

DISABLE_MAGIC_FUNCTIONS=true
# COMPLETION_WAITING_DOTS="true"

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
    curl -sL git.io/antigen > $ANTIGEN_PATH/antigen.zsh
fi

source $ANTIGEN_PATH/antigen.zsh

antigen use oh-my-zsh
antigen bundle git
antigen bundle colored-man-pages

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

antigen bundle denysdovhan/spaceship-prompt

antigen apply
