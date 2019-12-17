# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# oh-my-zsh
DISABLE_MAGIC_FUNCTIONS=true
COMPLETION_WAITING_DOTS="true"
ZSH_THEME=powerlevel10k/powerlevel10k

# zsh-autosuggestions
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=true

source $HOME/.antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle git
antigen bundle colored-man-pages

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

antigen theme romkatv/powerlevel10k

antigen apply

# User configuration


export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Documenti
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3

# alias vim=nvim
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

source $HOME/.local/bin/virtualenvwrapper_lazy.sh

# source <(kubectl completion zsh)
# source <(doctl completion zsh)
# source <(helm completion zsh)
# eval "$(pipenv --completion)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
