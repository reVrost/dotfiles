# If you come from bash you might have to change your $PATH.
export PATH=$HOME/go/bin:/$HOME/bin:/usr/local/bin:$PATH:/usr/local/go/bin:/usr/local/lua-language-server/bin:$(yarn global bin):/opt/homebrew/bin:$HOME/.local/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

export CR_PAT=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

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

plugins=(
	git
	zsh-autosuggestions
)

# ZSHRC plugin
source $ZSH/oh-my-zsh.sh
#source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# disable ctrl d from closing window
set -o ignoreeof

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Pure prompt
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure
zstyle :prompt:pure:git:stash show yes


# bindkeys remap
bindkey "ç" fzf-cd-widget
bindkey "ƒ" forward-word
bindkey "∫" backward-word
bindkey '^I^I' autosuggest-accept
# bindkey '^;' autosuggest-accept

# Aliases
alias bg='screen -d -m "$@"'
alias ch="curl cht.sh/$1"
alias k="kubectl"
alias pip=pip3
alias python=python3
alias v="nvim"
alias vi="nvim"
alias vic="cd ~/.config/nvim/lua;nvim"
alias vik="nvim ~/.config/kitty/kitty.conf"
alias vim="nvim"
alias workc="git log --shortstat --author=\"Kenley Bastari\" --since=\"2 weeks ago\" --until=\"1 week ago\" | grep \"files changed\" | awk '{files+=$1; inserted+=$4; deleted+=$6} END {print \"files changed\", files, \"lines inserted:\", inserted, \"lines deleted:\", deleted}'"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PKG_CONFIG_PATH="/usr/local/opt/libxml2/lib/pkgconfig:$PKG_CONFIG_PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv virtualenv-init -)"
fi

# zlib
export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include"

# direnv
eval "$(direnv hook zsh)"
export N_PREFIX="/usr/local/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

#GVM
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# emscripten
source ~/code/reVrost/emsdk/emsdk_env.sh > /dev/null 2>&1

# zoxide
eval "$(zoxide init zsh)"

# allow drag by ctrl+cmd
defaults write -g NSWindowShouldDragOnGesture YES


# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

ifast() {
    last_meal_time="$1"

    local hour=$(echo "$last_meal_time" | sed 's/\([0-9]*\).*/\1/')
    local meridian=$(echo "$last_meal_time" | sed 's/[0-9]*\(..\)/\1/')
    local difference=$((4+ hour))
    local fasting_end_time=$(( difference % 12))

    if [ "$difference" -gt 12 ]; then  # 720 minutes = 12 hours
        meridian="pm"
    else
        meridian="am"
    fi

    echo "16/8: breakfast at $fasting_end_time $meridian"
}

hex() {
    # Check if input is provided
    if [ $# -ne 1 ]; then
        echo "Usage: hex <hex_value>"
        return 1
    fi

    # Convert hexadecimal input to decimal
    decimal=$(printf "%d\n" $1)

    # Output the result
    echo "val: $decimal"
}

# Work specific
kdev() {
    echo "might need: aws sso login"
    aws --profile platform-nonprod-engineer sts get-caller-identity | jq
    aws --profile platform-nonprod-engineer eks update-kubeconfig --name dev --region us-east-2 --alias dev
    kubectl config set-context --current --namespace=dev
}
ksandbox() {
    echo "might need: aws sso login"
    aws --profile platform-nonprod-engineer sts get-caller-identity | jq
    aws --profile platform-nonprod-engineer eks update-kubeconfig --name sandbox --region us-east-2 --alias sandbox
    kubectl config set-context --current --namespace=sandbox
}

