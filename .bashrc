# .bashrc
#
# Author: Lorenzo Murarotto <lnzmrr@gmail.com>

[ -z "$PS1" ] && return # if not running interactively don't do anything

# Options

shopt -s histappend # append to history on quit instead of overwriting it.
shopt -s autocd     # automatically prepend cd when entering just a path in the shell.
shopt -s dotglob    # include filenames beginning with a dot in the results of pathname expansion.
set -o noclobber    # disallow existing files to be overwritten by redirection of shell output

# Variables

export HISTCONTROL=erasedups # stop logging of repeated identical commands
export HISTFILESIZE=10000    # expand the on disk history size
export HISTSIZE=500          # expand the in memory history size

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

### Starship

STARSHIP_PATH=$HOME/.local/bin

if [ ! -f $STARSHIP_PATH/starship ]; then
    echo "Installing starship!..."
    mkdir -p $STARSHIP_PATH
    curl -fsSL https://starship.rs/install.sh | sh -s -- --yes --bin-dir $STARSHIP_PATH >/dev/null
fi

eval "$($STARSHIP_PATH/starship init bash)"

### Local configuration

if [[ -f $HOME/.bashrc.local ]]; then
    source $HOME/.bashrc.local
fi
