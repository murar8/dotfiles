# .bashrc
#
# Author: Lorenzo Murarotto <lnzmrr@gmail.com>

if [[ $- != *i* ]]; then
    return # if not running interactively don't do anything
fi

# Options

shopt -s checkwinsize # check the window size after each command and update the values of LINES and COLUMNS
shopt -s histappend   # append to history on quit instead of overwriting it
shopt -s autocd       # automatically prepend cd when entering just a path in the shell
shopt -s dotglob      # include filenames beginning with a dot in the results of pathname expansion

set -o noclobber # disallow existing files to be overwritten by redirection of shell output

# Variables

export HISTCONTROL=ignoreboth # stop logging of repeated commands and lines starting with space
export HISTFILESIZE=10000     # expand the on disk history size
export HISTSIZE=1000          # expand the in memory history size

# Aliases

ll() {
    ls -Alhg --color=auto $@
}

cc() {
    cd "$@" && ll
}

dot() {
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME "$@"
}

dotup() {
    if [ "$#" -ne 1 ]; then
        echo "dotup: Expected one argument."
        return 1
    fi

    dot add -u
    dot commit -m "$1"
    dot -c push.default=current push origin
}

### Completions

if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
fi

if [[ -f /usr/share/bash-completion/completions/git ]]; then
    source /usr/share/bash-completion/completions/git
    __git_complete dot __git_main
fi

bind "set show-all-if-ambiguous on"    # show auto-completion list without double tab
bind "set completion-ignore-case on"   # ignore case on completion
bind '"\e[A": history-search-backward' # get completions from history
bind '"\e[B": history-search-forward'  # ↑ ↑ ↑

### Editor

if command -v code &>/dev/null && ([ "$TERM_PROGRAM" = 'vscode' ] || [ -t 0 ]); then
    export EDITOR="$(which code) -w"
elif command -v nvim &>/dev/null; then
    export EDITOR="$(which nvim)"
elif command -v vim &>/dev/null; then
    export EDITOR="$(which vim)"
fi

### Prompt

black='\[\033[30m\]'
blue='\[\033[34m\]'
cyan='\[\033[36m\]'
green='\[\033[32m\]'
purple='\[\033[35m\]'
red='\[\033[31m\]'
white='\[\033[37m\]'
yellow='\[\033[33m\]'
clear='\[\033[0m\]'

prompt() {
    local exit_code="$?"
    local current_branch=$(command -v git &>/dev/null && git symbolic-ref --short HEAD 2>/dev/null)

    PS1="${cyan}\u${blue}@\h ${purple}\w"
    if [[ -n $current_branch ]]; then PS1+=" ${green}${current_branch}"; fi
    if [[ exit_code -eq 0 ]]; then PS1+=" ${white}\$"; else PS1+=" ${red}!"; fi
    PS1+=" ${clear}"
}

PROMPT_COMMAND=prompt
PROMPT_DIRTRIM=1

### Local configuration

if [[ -f $HOME/.bashrc.local ]]; then
    source $HOME/.bashrc.local
fi
