#!/usr/bin/env bash

# If not running interactively don't do anything.
if [[ $- != *i* ]]; then
    return
fi

### System configuration

if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

### Options

shopt -s checkwinsize # Check the window size after each command and update the values of LINES and COLUMNS.
shopt -s histappend   # Append to history on quit instead of overwriting it.
shopt -s cmdhist      # Save multi-line commands as one command.
shopt -s autocd       # Automatically prepend cd when entering just a path in the shell.
shopt -s dotglob      # Include filenames beginning with a dot in the results of pathname expansion.
shopt -s nullglob     # When a glob expands to nothing, make it an empty string.

set -o noclobber # Disallow existing files to be overwritten by redirection of shell output.

set -o vi # Use vi key bindings in the shell.

### History

# erasedups  => Remove all but the last identical command.
# ignoreboth => Avoid saving consecutive identical commands, and commands that start with a space.
export HISTCONTROL=erasedups:ignoreboth

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "

### Aliases

copy() {
    xclip -sel clip "$@"
}

paste() {
    xclip -o -sel clip "$@"
}

la() {
    ls -Alhg --color=auto "$@"
}

clob() {
    set +o noclobber
}

dot() {
    git --git-dir="$HOME"/.dotfiles --work-tree="$HOME" "$@"
}

dotup() {
    if [ "$#" -eq 1 ]; then
        dot add -u
        dot commit -m "$1"
        dot push origin main
    else
        echo "Expected a commit message."
        return 1
    fi

}

lz() {
    if [ "$#" -eq 1 ]; then
        nvim --headless "+Lazy! $1" +qa
    else
        echo "Expected a commit message."
        return 1
    fi
}

if command -v lazygit &>/dev/null; then
    lazydot() {
        GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME lazygit
    }
fi

### Completions

if [ -f "$HOME/.completions.bash" ]; then
    source "$HOME/.completions.bash"
fi

### Editor

if command -v nvim &>/dev/null; then
    EDITOR="$(command -v nvim)"
elif [ "$ZED_TERM" = 'true' ] || command -v zed &>/dev/null; then
    EDITOR="$(command -v zed) --wait"
elif command -v code &>/dev/null && [ "$TERM_PROGRAM" = 'vscode' ] && [ -z "$CURSOR_TRACE_ID" ]; then
    EDITOR="$(command -v code) --wait"
elif command -v vim &>/dev/null; then
    EDITOR="$(command -v vim)"
fi

VISUAL=$EDITOR
SUDO_EDITOR=$EDITOR
export VISUAL EDITOR SUDO_EDITOR

### Prompt

# yellow='\[\033[33m\]'
blue='\[\033[34m\]'
clear='\[\033[0m\]'
cyan='\[\033[36m\]'
# green='\[\033[32m\]'
purple='\[\033[35m\]'
red='\[\033[31m\]'
white='\[\033[37m\]'

prompt() {
    local exit_code="$?"

    history -a # Append the current session history to the content of the history file.

    local git_ps1
    if command -v git &>/dev/null; then
        export GIT_PS1_SHOWUPSTREAM="auto"
        export GIT_PS1_SHOWDIRTYSTATE=true
        export GIT_PS1_SHOWCOLORHINTS=true
        export GIT_PS1_SHOWUNTRACKEDFILES=true
        git_ps1=$(__git_ps1)
    fi

    if command -v direnv &>/dev/null; then
        direnv_allowed=$(direnv status | grep -oP 'Found RC allowed \K\w+')
    fi

    PS1="${cyan}\u${blue}@\h ${purple}\w"
    if [[ -n $git_ps1 ]]; then PS1+="${clear}${git_ps1}"; fi
    if [[ $direnv_allowed == 'true' ]]; then PS1+=" 🔓"; fi
    if [[ $direnv_allowed == 'false' ]]; then PS1+=" 🔐"; fi
    if [[ exit_code -eq 0 ]]; then PS1+=" ${white}\$"; else PS1+=" ${red}!"; fi
    PS1+=" ${clear}"
}

PROMPT_COMMAND=('prompt')
PROMPT_DIRTRIM=1 # Trim the working directory to the last directory name.

### Environment

if command -v fzf &>/dev/null && fzf --bash &>/dev/null; then
    eval "$(fzf --bash)"
fi

if command -v direnv &>/dev/null; then
    eval "$(direnv hook bash)"
fi

if [ -f "$HOME"/.nvm/nvm.sh ] && [ -f "$HOME"/.nvm/bash_completion ]; then
    export NVM_DIR="$HOME/.nvm"
    . "$NVM_DIR/nvm.sh"
    . "$NVM_DIR/bash_completion"
fi

# rustup
if [ -f "$HOME"/.cargo/env ]; then
    . "$HOME"/.cargo/env
fi

### Local configuration
if [ -f "$HOME"/.local.bashrc ]; then
    source "$HOME"/.local.bashrc
fi
