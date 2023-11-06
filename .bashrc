#!/usr/bin/env bash

# if not running interactively don't do anything.
if [[ $- != *i* ]]; then
    return
fi

### Options

shopt -s checkwinsize # Check the window size after each command and update the values of LINES and COLUMNS.
shopt -s histappend   # Append to history on quit instead of overwriting it.
shopt -s cmdhist      # Save multi-line commands as one command.
shopt -s autocd       # Automatically prepend cd when entering just a path in the shell.
shopt -s dotglob      # Include filenames beginning with a dot in the results of pathname expansion.
shopt -s nullglob     # When a glob expands to nothing, make it an empty string.

set -o noclobber # Disallow existing files to be overwritten by redirection of shell output.

### Variables

# erasedups  => Remove all but the last identical command.
# ignoreboth => Avoid saving consecutive identical commands, and commands that start with a space.
export HISTCONTROL=erasedups:ignoreboth

export HISTFILESIZE=1000000 # Expand the on disk history size.
export HISTSIZE=1000000     # Expand the in memory history size.

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
    dot push origin main
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
bind "set completion-map-case on"      # Treat hyphens and underscores as equivalent.
bind '"\e[A": history-search-backward' # Get completions from history (backward).
bind '"\e[B": history-search-forward'  # Get completions from history (forward).

### Editor

if command -v code &>/dev/null && [ "$TERM_PROGRAM" = 'vscode' ]; then
    EDITOR="$(which code) --wait"
    export EDITOR
elif command -v nvim &>/dev/null; then
    EDITOR="$(which nvim)"
    export EDITOR
elif command -v vim &>/dev/null; then
    EDITOR="$(which vim)"
    export EDITOR
fi

### Prompt

yellow='\[\033[33m\]'
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

    local git_branch
    local git_dirty
    local direnv_allowed

    if command -v git &>/dev/null; then
        git_branch=$(git symbolic-ref --short HEAD 2>/dev/null)
        git_dirty=$(git status --porcelain 2>/dev/null | wc -l)
    fi
    if command -v direnv &>/dev/null; then
        direnv_allowed=$(direnv status | grep -oP 'Found RC allowed \K\w+')
    fi

    PS1="${cyan}\u${blue}@\h ${purple}\w"
    if [[ -n $git_branch ]]; then PS1+=" ${green}${git_branch}"; fi
    if [[ $git_dirty -gt 0 ]]; then PS1+="${yellow}[${git_dirty}]"; fi
    if [[ $direnv_allowed == 'true' ]]; then PS1+=" ${green}[direnv]"; fi
    if [[ $direnv_allowed == 'false' ]]; then PS1+=" ${red}[direnv]"; fi
    if [[ exit_code -eq 0 ]]; then PS1+=" ${white}\$"; else PS1+=" ${red}!"; fi
    PS1+=" ${clear}"
}

PROMPT_COMMAND=prompt
PROMPT_DIRTRIM=1 # Trim the working directory to the last directory name.

### Environment

if command -v direnv &>/dev/null; then
    eval "$(direnv hook bash)"
fi

### Local configuration

if [[ -f $HOME/.bashrc.local ]]; then
    # shellcheck disable=SC1091
    source "$HOME"/.bashrc.local
fi
