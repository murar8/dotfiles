#!/bin/bash
# Author:   Lorenzo Murarotto <lnzmrr@gmail.com>
# Repo:     https://github.com/murar8/dotfiles

# if not running interactively don't do anything.
if [[ $- != *i* ]]; then
    return
fi

### Options

shopt -s checkwinsize # Check the window size after each command and update the values of LINES and COLUMNS.
shopt -s histappend   # Append to history on quit instead of overwriting it.
shopt -s autocd       # Automatically prepend cd when entering just a path in the shell.
shopt -s dotglob      # Include filenames beginning with a dot in the results of pathname expansion.
shopt -s nullglob     # When a glob expands to nothing, make it an empty string.

set -o noclobber # Disallow existing files to be overwritten by redirection of shell output.
set -o vi        # Enable vi mode.

### Variables

# erasedups  => Remove all but the last identical command.
# ignoreboth => Avoid saving consecutive identical commands, and commands that start with a space.
export HISTCONTROL=erasedups:ignoreboth

export HISTFILESIZE=10000 # Expand the on disk history size.
export HISTSIZE=1000      # Expand the in memory history size.

### Aliases

ll() {
    ls -Alhg --color=auto "$@"
}

extract() {
    if [ "$#" -ne 1 ]; then
        echo "Expected one argument."
        return 1
    fi

    if [ ! -f "$1" ]; then
        echo "'$1' is not a valid file."
        return 1
    fi

    case $1 in
    *.tar.bz2) tar xjf "$1" ;;
    *.tar.gz) tar xzf "$1" ;;
    *.bz2) bunzip2 "$1" ;;
    *.rar) rar x "$1" ;;
    *.gz) gunzip "$1" ;;
    *.tar) tar xf "$1" ;;
    *.tbz2) tar xjf "$1" ;;
    *.tgz) tar xzf "$1" ;;
    *.zip) unzip "$1" ;;
    *.Z) uncompress "$1" ;;
    *.7z) 7z x "$1" ;;
    *) echo "Don't know how to extract '$1'." ;;
    esac
}

dot() {
    git --git-dir="$HOME"/.dotfiles -C "$HOME" --work-tree="$HOME" "$@"
}

dotup() {
    if [ "$#" -ne 1 ]; then
        echo "Expected a commit message."
        return 1
    fi

    dot add -u
    dot commit -m "$1"
    dot -c push.default=current push origin
}

### Completions

if command -v terraform &>/dev/null; then
    complete -C "$(which terraform)" terraform
fi

if command -v doctl &>/dev/null; then
    # shellcheck disable=SC1090
    source <(doctl completion bash)
fi

if command -v kubectl &>/dev/null; then
    # shellcheck disable=SC1090
    source <(kubectl completion bash)
fi

if command -v devpod &>/dev/null; then
    # shellcheck disable=SC1090
    source <(devpod completion bash)
fi

if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
fi

if [[ -f /usr/share/bash-completion/completions/git ]]; then
    source /usr/share/bash-completion/completions/git
    __git_complete dot __git_main
fi

bind "set show-all-if-ambiguous on"    # Show auto-completion list without double tab.
bind "set completion-ignore-case on"   # Ignore case on completion.
bind '"\e[A": history-search-backward' # Get completions from history (backward).
bind '"\e[B": history-search-forward'  # Get completions from history (forward).

### Editor

if command -v nvim &>/dev/null; then
    EDITOR="$(which nvim)"
    export EDITOR
elif command -v vim &>/dev/null; then
    EDITOR="$(which vim)"
    export EDITOR
fi

### Prompt

# black='\[\033[30m\]'
# yellow='\[\033[33m\]'
blue='\[\033[34m\]'
clear='\[\033[0m\]'
cyan='\[\033[36m\]'
green='\[\033[32m\]'
purple='\[\033[35m\]'
red='\[\033[31m\]'
white='\[\033[37m\]'

prompt() {
    local exit_code="$?"

    history -a # Append the current session history to the content of the history file.

    local current_branch
    current_branch=$(command -v git &>/dev/null && git symbolic-ref --short HEAD 2>/dev/null)

    PS1="${cyan}\u${blue}@\h ${purple}\w"
    if [[ -n $current_branch ]]; then PS1+=" ${green}${current_branch}"; fi
    if [[ exit_code -eq 0 ]]; then PS1+=" ${white}\$"; else PS1+=" ${red}!"; fi
    PS1+=" ${clear}"
}

PROMPT_COMMAND=prompt
PROMPT_DIRTRIM=1

### Local configuration

if [[ -f $HOME/.bashrc.local ]]; then
    # shellcheck disable=SC1091
    source "$HOME"/.bashrc.local
fi
