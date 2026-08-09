# vim: filetype=sh

if [ -f /usr/share/bash-completion/bash_completion ]; then
	source /usr/share/bash-completion/bash_completion
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

	for c in ncl ncc ncr npi npc npr nop noc; do
		if declare -F "$c" >/dev/null; then
			complete -F _agent_complete "$c"
		fi
	done
fi

for f in /usr/share/bash-completion/completions/git /run/current-system/sw/share/bash-completion/completions/git; do
	if [ -f "$f" ]; then
		source "$f"
		# git shells out to the subcommand to enumerate its flags, and $HOME
		# is not a repository -- the dotfiles repo is bare at ~/.dotfiles.
		# Without this, `dot commit --a<TAB>` returns nothing and only
		# subcommand names complete.
		_dot_main() {
			GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME __git_main "$@"
		}
		__git_complete dot _dot_main
		break
	fi
done

for f in /usr/share/git-core/contrib/completion/git-prompt.sh /run/current-system/sw/share/bash-completion/completions/git-prompt.sh; do
	if [ -f "$f" ]; then
		source "$f"
		break
	fi
done

if command -v register-python-argcomplete &>/dev/null && command -v pipx &>/dev/null; then
	eval "$(register-python-argcomplete pipx)"
fi
