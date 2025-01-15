#!/usr/bin/env bash

# If not running interactively don't do anything.
if [[ $- != *i* ]]; then
    return
fi

### System configuration

if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# Ghostty shell integration for Bash. This should be at the top of your bashrc!
if [ -n "${GHOSTTY_RESOURCES_DIR}" ]; then
    builtin source "${GHOSTTY_RESOURCES_DIR}/shell-integration/bash/ghostty.bash"
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
    if [ "$#" -ne 1 ]; then
        echo "Expected a commit message."
        return 1
    fi

    dot add -u
    dot commit -m "$1"
    dot push origin main
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

# Cursor

if [ -d "$HOME/.appimage" ]; then
    CURSOR_APPIMAGE=$(find "$HOME/.appimage" -name 'cursor-*.AppImage' -print | sort | tail -n1)
    if [ -n "$CURSOR_APPIMAGE" ]; then
        cursor() {
            "$CURSOR_APPIMAGE" --no-sandbox "$@"
        }
    fi
fi

### IntelliJ

INTELLIJ_IDE=$(basename "$GIO_LAUNCHED_DESKTOP_FILE" .desktop | sed -n 's/jetbrains-\([^-]\+\)-.\+/\1/p')
if [ -n "$INTELLIJ_IDE" ]; then
    ij() {
        $INTELLIJ_IDE "$@"
    }
fi

### Editor

if [ "$TERMINAL_EMULATOR" = 'JetBrains-JediTerm' ]; then
    EDITOR="$INTELLIJ_IDE --wait"
elif [ -n "$CURSOR_TRACE_ID" ] && [ "$TERM_PROGRAM" = 'vscode' ]; then
    EDITOR="$CURSOR_APPIMAGE --no-sandbox --wait"
elif command -v code &>/dev/null && [ "$TERM_PROGRAM" = 'vscode' ]; then
    EDITOR="code --wait"
elif command -v nvim &>/dev/null; then
    EDITOR="$(which nvim)"
elif command -v vim &>/dev/null; then
    EDITOR="$(which vim)"
fi

VISUAL=$EDITOR
export VISUAL
export EDITOR

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
    if [[ $direnv_allowed == 'true' ]]; then PS1+=" ${green}🔒"; fi
    if [[ $direnv_allowed == 'false' ]]; then PS1+=" ${red}🔒"; fi
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
