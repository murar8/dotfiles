# vim: filetype=sh

# Source the first of $@ (relative paths) found under any data root: the
# XDG ones, plus FHS and the NixOS system profile explicitly, since neither is
# guaranteed to appear in XDG_DATA_DIRS.
_source_first_data() {
	local rel d dirs=() candidates=()
	IFS=: read -ra dirs <<<"$XDG_DATA_DIRS"
	dirs+=(/usr/share /run/current-system/sw/share)
	for rel in "$@"; do
		for d in "${dirs[@]}"; do
			candidates+=("$d/$rel")
		done
	done
	_source_first "${candidates[@]}"
}

# Some systems (NixOS) load this from the system rc before we get here.
if ! declare -F _init_completion >/dev/null; then
	_source_first_data bash-completion/bash_completion
fi

if command -v terraform &>/dev/null; then
	complete -C "$(command -v terraform)" terraform
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

if command -v goldwarden &>/dev/null; then
	source <(goldwarden completion bash)
fi

if command -v deno &>/dev/null; then
	source <(deno completions bash)
fi

if command -v helm &>/dev/null; then
	source <(helm completion bash)
fi

if command -v mongocli &>/dev/null; then
	source <(mongocli completion bash)
fi

if command -v fnm &>/dev/null; then
	source <(fnm completions --shell bash)
fi

if command -v nono &>/dev/null; then
	source <(nono completion bash)

	# _agent_complete calls _nono by name; say so if a generator change renames it.
	if ! declare -F _nono >/dev/null; then
		echo ".completions.bash: nono completion no longer defines _nono" >&2
	fi

	# The agent entrypoints in .bashrc take `nono run` arguments up to `--`,
	# so rewrite the line and hand it to nono's own completion. Words past
	# `--` belong to the agent and are left alone.
	_agent_complete() {
		if [[ " ${COMP_WORDS[*]:1:COMP_CWORD-1} " == *" -- "* ]]; then
			return
		fi
		COMP_WORDS=(nono run "${COMP_WORDS[@]:1}")
		((COMP_CWORD += 1))
		_nono nono "$2" "$3"
	}

	# Only the entrypoints .bashrc actually defined, with the same options nono
	# registers itself with: `_nono` emits no COMPREPLY for path-valued flags and
	# leans on `-o default` for the filename fallback.
	for _c in ncl npi nop; do
		if declare -F "$_c" >/dev/null; then
			complete -o bashdefault -o default -o nosort -F _agent_complete "$_c"
		fi
	done
	unset _c
fi

if _source_first_data bash-completion/completions/git git-core/contrib/completion/git-completion.bash; then
	# git shells out to the subcommand to enumerate its flags, and $HOME
	# is not a repository -- the dotfiles repo is bare at ~/.dotfiles.
	# Without this, `dot commit --a<TAB>` returns nothing and only
	# subcommand names complete.
	_dot_main() {
		GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME __git_main "$@"
	}
	__git_complete dot _dot_main
fi

_source_first_data git-core/contrib/completion/git-prompt.sh \
	bash-completion/completions/git-prompt.sh

if command -v register-python-argcomplete &>/dev/null && command -v pipx &>/dev/null; then
	eval "$(register-python-argcomplete pipx)"
fi
