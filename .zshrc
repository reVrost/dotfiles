#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
# Exports
export GOPATH=$HOME/Code/go
PATH=$PATH:$GOPATH/bin:$HOME/anaconda3/bin
export PATH="$PATH:$HOME/Library/flutter/bin"

bindkey '^ ' autosuggest-accept

function zsh_stats() {
  fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n20
}

alias vim="nvim"
alias vi="nvim"
alias ovim="vim"
alias npm="yarn"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# make fzf to utilize ripgrep
export FZF_DEFAULT_COMMAND='rg --files --hidden'
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
