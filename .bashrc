#!/usr/bin/env bash

if [[ $- != *i* ]]; then
	return
fi

### System configuration

if [ -f /etc/bashrc ]; then source /etc/bashrc; fi
if [ -f /etc/bash.bashrc ]; then source /etc/bash.bashrc; fi

### Options

shopt -s checkwinsize # Check the window size after each command and update the values of LINES and COLUMNS.
shopt -s histappend   # Append to history on quit instead of overwriting it.
shopt -s cmdhist      # Save multi-line commands as one command.
shopt -s autocd       # Automatically prepend cd when entering just a path in the shell.
shopt -s dotglob      # Include filenames beginning with a dot in the results of pathname expansion.
shopt -s failglob     # When a glob matches nothing, fail instead of dropping the word (nullglob) or passing it through literally.

set -o noclobber # Disallow existing files to be overwritten by redirection of shell output.

set -o vi # Use vi key bindings in the shell.

### History

# erasedups  => Remove all but the last identical command.
# ignoreboth => Skip consecutive duplicates, and commands starting with a space.
export HISTCONTROL=erasedups:ignoreboth

# Empty means unlimited: undocumented, see
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "

### Commands

# openSUSE's /etc/bash.bashrc ships `alias la`, and aliases expand at parse
# time: `la() {` becomes `ls -la() {`, a syntax error that aborts the rest of
# this file. Not reproducible under `bash -n`, which does not expand aliases.
if alias la &>/dev/null; then unalias la; fi

la() {
	ls -Alhg --color=auto "$@"
}

clob() {
	set +o noclobber
}

dot() {
	git --git-dir="$HOME"/.dotfiles --work-tree="$HOME" "$@"
}

# force skips the confirmation buffer, which needs a UI to accept.
packupdate() {
	nvim --headless '+lua vim.pack.update(nil, { force = true })' +qa
}

if command -v nono &>/dev/null; then
	# Args before `--` are nono's, the rest the agent's:
	#   ncl --extends koda --allow ~/scratch -- -p 'fix tests'
	_agent_run() {
		local agent=$1 agent_flag=$2
		shift 2

		local nono_args=()
		while [ "$#" -gt 0 ]; do
			if [ "$1" = '--' ]; then
				shift
				break
			else
				nono_args+=("$1")
				shift
			fi
		done

		# ${x:+"$x"} expands to nothing when unset, so no empty arg reaches pi.
		nono run --profile "$agent" "${nono_args[@]}" -- \
			"$agent" ${agent_flag:+"$agent_flag"} "$@"
	}

	if command -v claude &>/dev/null; then
		ncl() { _agent_run claude --dangerously-skip-permissions "$@"; }
	fi

	# pi has no permission system; its tools always run.
	if command -v pi &>/dev/null; then
		npi() { _agent_run pi '' "$@"; }
	fi

	if command -v opencode &>/dev/null; then
		nop() { _agent_run opencode --auto "$@"; }
	fi
else
	# No permission-skipping flags: unsandboxed, the agent's prompts are the
	# only backstop left.
	if command -v claude &>/dev/null; then
		alias cl='claude'
		alias clc='claude --continue'
		alias clr='claude --resume'
	fi

	if command -v pi &>/dev/null; then
		alias pic='pi --continue'
		alias pir='pi --resume'
	fi

	# opencode has no --resume; its equivalent is --session <id>.
	if command -v opencode &>/dev/null; then
		alias op='opencode'
		alias opc='opencode --continue'
	fi
fi

if command -v lazygit &>/dev/null; then
	lazydot() {
		GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME lazygit "$@"
	}
fi

### Completions

if [ -f "$HOME/.completions.bash" ]; then
	source "$HOME/.completions.bash"
fi

### Editor

# Context before availability: a GUI editor only wins inside its own terminal.
if [ "$ZED_TERM" = 'true' ] && command -v zed &>/dev/null; then
	EDITOR="$(command -v zed) --wait"
elif [ "$TERM_PROGRAM" = 'vscode' ] && [ -z "$CURSOR_TRACE_ID" ] && command -v code &>/dev/null; then
	EDITOR="$(command -v code) --wait"
elif command -v nvim &>/dev/null; then
	EDITOR="$(command -v nvim)"
elif command -v vim &>/dev/null; then
	EDITOR="$(command -v vim)"
fi

# Exporting these empty is worse than leaving them unset: callers that test for
# presence rather than emptiness would exec "".
if [ -n "$EDITOR" ]; then
	VISUAL=$EDITOR
	SUDO_EDITOR=$EDITOR
	export VISUAL EDITOR SUDO_EDITOR
fi

### Prompt

# Read by git-prompt.sh, hence no export. Grouped so one directive covers all
# four; shellcheck can't see the reads across the source.
# shellcheck disable=SC2034
{
	GIT_PS1_SHOWUPSTREAM="auto"
	GIT_PS1_SHOWDIRTYSTATE=true
	GIT_PS1_SHOWCOLORHINTS=true
	GIT_PS1_SHOWUNTRACKEDFILES=true
}

prompt() {
	local exit_code="$?"

	history -a # Append the current session history to the content of the history file.

	local blue='\[\033[34m\]'
	local clear='\[\033[0m\]'
	local cyan='\[\033[36m\]'
	local purple='\[\033[35m\]'
	local red='\[\033[31m\]'
	local white='\[\033[37m\]'

	local direnv_allowed
	if command -v direnv &>/dev/null && [[ $(direnv status) =~ Found\ RC\ allowed\ ([[:alnum:]]+) ]]; then
		direnv_allowed=${BASH_REMATCH[1]}
	fi

	local pre="${cyan}\u${blue}@\h ${purple}\w${clear}"

	local post=""
	# direnv >= 2.28 reports 0=allowed, 1=not allowed, 2=denied; older
	# versions reported true/false.
	if [[ $direnv_allowed == @(0|true) ]]; then post+=" 🔓"; fi
	if [[ $direnv_allowed == @(1|false) ]]; then post+=" 🔐"; fi
	if [[ $direnv_allowed == 2 ]]; then post+=" ⛔"; fi
	if ((exit_code == 0)); then post+=" ${white}\$"; else post+=" ${red}!"; fi
	post+=" ${clear}"

	if declare -F __git_ps1 >/dev/null; then
		# Two-argument form emits the branch name as a variable reference. The
		# `$(__git_ps1)` form put it in PS1 raw, so a branch named `$(cmd)` ran
		# cmd when the prompt was drawn.
		__git_ps1 "$pre" "$post"
	else
		PS1="$pre$post"
	fi
}

PROMPT_DIRTRIM=1 # Trim the working directory to the last directory name.

### Environment

if command -v fzf &>/dev/null; then
	eval "$(fzf --bash)"
fi

if command -v direnv &>/dev/null; then
	eval "$(direnv hook bash)"
fi

# One version manager only: both put a shim directory on PATH, and the loser's
# `use` then silently resolves to the winner's node. fnm first, it is faster.
if command -v fnm &>/dev/null; then
	eval "$(fnm env --use-on-cd --shell bash)"
elif [ -f "$HOME"/.nvm/nvm.sh ] && [ -f "$HOME"/.nvm/bash_completion ]; then
	export NVM_DIR="$HOME/.nvm"
	. "$NVM_DIR/nvm.sh"
	. "$NVM_DIR/bash_completion"
fi

if [ -f "$HOME"/.cargo/env ]; then
	. "$HOME"/.cargo/env
fi

### Prompt command

# Last, and appended: the hook generators above edit PROMPT_COMMAND as a string
# and their "already here?" guards don't recognise the array form, so
# converting it earlier makes them re-register (direnv does exactly this).
PROMPT_COMMAND+=('prompt')

### Multiplexer

if [ -n "$SSH_CONNECTION$SSH_TTY$SSH_CLIENT" ] && command -v zellij &>/dev/null; then
	# No ZELLIJ_AUTO_ATTACH: `attach -c` ignores `session_name`.
	export ZELLIJ_AUTO_EXIT=true
	eval "$(zellij setup --generate-auto-start bash)"
fi

### Local configuration

if [ -f "$HOME"/.local.bashrc ]; then
	source "$HOME"/.local.bashrc
fi
