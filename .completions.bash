# vim: filetype=sh

if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
fi

if command -v terraform &>/dev/null; then
    complete -C "$(which terraform)" terraform
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

for f in /usr/share/bash-completion/completions/git /run/current-system/sw/share/bash-completion/completions/git; do
    if [ -f "$f" ]; then
        source "$f"
        __git_complete dot __git_main
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

if [ -f "$HOME/.bash_completions/ir.sh" ]; then
    source "$HOME/.bash_completions/ir.sh"
fi

# if command -v poetry &>/dev/null; then
#     source <(poetry completions bash)
# fi

# if command -v doctl &>/dev/null; then
#     source <(doctl completion bash)
# fi
