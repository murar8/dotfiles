# vim: filetype=sh

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

if command -v doctl &>/dev/null; then
    source <(mongocli completion bash)
fi

if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
fi

if [ -f /usr/share/bash-completion/completions/git ]; then
    source /usr/share/bash-completion/completions/git
    __git_complete dot __git_main
fi

if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
    source /usr/share/git-core/contrib/completion/git-prompt.sh
fi

if command -v register-python-argcomplete &>/dev/null && command -v pipx &>/dev/null; then
    eval "$(register-python-argcomplete pipx)"
fi

if [ -f "$HOME/.bash_completions/ir.sh" ]; then
    source "$HOME/.bash_completions/ir.sh"
fi

# https://github.com/ollama/ollama/issues/1653#issuecomment-2184527185
#shellcheck disable=SC2207
_complete_ollama() {
    local cur prev words cword
    _init_completion -n : || return
    if [[ ${cword} -eq 1 ]]; then
        COMPREPLY=($(compgen -W "serve create show run push pull list ps cp rm help" -- "${cur}"))
    elif [[ ${cword} -eq 2 ]]; then
        case "${prev}" in
        run | show | cp | rm | push | list)
            WORDLIST=$( (ollama list 2>/dev/null || echo "") | tail -n +2 | cut -d "	" -f 1)
            COMPREPLY=($(compgen -W "${WORDLIST}" -- "${cur}"))
            __ltrim_colon_completions "$cur"
            ;;
        esac
    fi
}
complete -F _complete_ollama ollama

# if command -v poetry &>/dev/null; then
#     source <(poetry completions bash)
# fi

# if command -v doctl &>/dev/null; then
#     source <(doctl completion bash)
# fi
