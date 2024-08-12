#!/usr/bin/env bash

# If not running interactively don't do anything.
if [[ $- != *i* ]]; then
    return
fi

### System configuration

if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

### Local configuration

if [ -f "$HOME"/.local.bashrc ]; then
    source "$HOME"/.local.bashrc
fi

### Options

shopt -s checkwinsize # Check the window size after each command and update the values of LINES and COLUMNS.
shopt -s histappend   # Append to history on quit instead of overwriting it.
shopt -s cmdhist      # Save multi-line commands as one command.
shopt -s autocd       # Automatically prepend cd when entering just a path in the shell.
shopt -s dotglob      # Include filenames beginning with a dot in the results of pathname expansion.
shopt -s nullglob     # When a glob expands to nothing, make it an empty string.

set -o noclobber # Disallow existing files to be overwritten by redirection of shell output.

### History

# erasedups  => Remove all but the last identical command.
# ignoreboth => Avoid saving consecutive identical commands, and commands that start with a space.
export HISTCONTROL=erasedups:ignoreboth

export HISTFILESIZE=1000000 # Expand the on disk history size.
export HISTSIZE=1000000     # Expand the in memory history size.

### Extract script

EXTRACT_SCRIPT_PATH="$HOME"/.local/share/com.github.murar8.dotfiles
if [ ! -f "$EXTRACT_SCRIPT_PATH"/extract.sh ] && command -v curl &>/dev/null; then
    echo "Installing xvoland/Extract..."
    mkdir -p "$EXTRACT_SCRIPT_PATH"
    curl -sL https://raw.githubusercontent.com/xvoland/Extract/master/extract.sh -o "$EXTRACT_SCRIPT_PATH"/extract.sh
fi
if [ -f "$EXTRACT_SCRIPT_PATH"/extract.sh ]; then
    . "$EXTRACT_SCRIPT_PATH"/extract.sh
fi

### Aliases

la() {
    ls -Alhg --color=auto "$@"
}

dot() {
    git --git-dir="$HOME"/.dotfiles --work-tree="$HOME" "$@"
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

if command -v aws_completer &>/dev/null; then
    complete -C "$(which aws_completer)" aws
fi

if command -v doctl &>/dev/null; then
    source <(doctl completion bash)
fi

if command -v kubectl &>/dev/null; then
    source <(kubectl completion bash)
fi

if command -v devpod &>/dev/null; then
    source <(devpod completion bash)
fi

if command -v minikube &>/dev/null; then
    source <(minikube completion bash)
fi

if command -v rustup &>/dev/null; then
    source <(rustup completions bash)
    source <(rustup completions bash cargo)
fi

if command -v scala-cli &>/dev/null; then
    _scala-cli_completions() {
        local IFS=$'\n'
        eval "$(scala-cli complete bash-v1 "$((COMP_CWORD + 1))" "${COMP_WORDS[@]}")"
    }
    complete -F _scala-cli_completions scala-cli
fi

if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
fi

if [ -f /usr/share/bash-completion/completions/git ]; then
    source /usr/share/bash-completion/completions/git
    __git_complete dot __git_main
fi

if [ -f /etc/bash_completion.d/fzf ]; then
    source /etc/bash_completion.d/fzf
fi

if [ -f /usr/share/fzf/shell/key-bindings.bash ]; then
    source /usr/share/fzf/shell/key-bindings.bash
fi

if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
    source /usr/share/doc/fzf/examples/key-bindings.bash
fi

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
        git_branch=$(git symbolic-ref --short HEAD 2>/dev/null | sed 's/\(.\{16\}\).*\(.\{16\}\)/\1...\2/')
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

PROMPT_COMMAND=('prompt')
PROMPT_DIRTRIM=1 # Trim the working directory to the last directory name.

### Environment

if command -v direnv &>/dev/null; then
    eval "$(direnv hook bash)"
fi

# NVM

if [ -f "$HOME"/.nvm/nvm.sh ] && [ -f "$HOME"/.nvm/bash_completion ]; then
    export NVM_DIR="$HOME/.nvm"
    . "$NVM_DIR/nvm.sh"
    . "$NVM_DIR/bash_completion"
fi

# rustup

if [ -f "$HOME"/.cargo/env ]; then
    . "$HOME"/.cargo/env
fi
