# If you come from bash you might have to change your $PATH.
export PATH="$PATH:$HOME/go/bin:$HOME/bin:/usr/local/bin:/usr/local/go/bin:/usr/local/lua-language-server/bin:/opt/homebrew/bin:$HOME/.local/bin:$HOME/.local/share/mise/shims"

# Path to your oh-my-zsh installation.
# export ZSH="$HOME/.oh-my-zsh"

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

# plugins=(
# 	git
#   kubectl
# 	zsh-autosuggestions
#   zsh-syntax-highlighting
# )

# Pure prompt
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit;
prompt pure
zstyle :prompt:pure:git:stash show yes

# ZSHRC plugin
# source $ZSH/oh-my-zsh.sh
autoload -Uz compinit
compinit
source ~/.zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/custom/plugins/git.plugin.zsh
source ~/.zsh/custom/plugins/kubectl.plugin.zsh

# disable ctrl d from closing window
set -o ignoreeof

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# bindkeys remap
bindkey '^Z' fancy-ctrl-z
bindkey "ç" fzf-cd-widget
bindkey "ƒ" forward-word
bindkey "∫" backward-word
# bindkey '^I^I' autosuggest-accept
# bindkey '^;' autosuggest-accept
bindkey '^G' clear-git-status
# bindkey '^;' autosuggest-accept

globalias() {
   if [[ "$LBUFFER" =~ [[:upper:]]+$ ]]; then
     zle _expand_alias
   fi
   zle expand-word
   zle self-insert
}
zle -N globalias

# space expands all aliases, including global
bindkey -M emacs " " globalias
bindkey -M viins " " globalias

# control-space to make a normal space
bindkey -M emacs "^ " magic-space
bindkey -M viins "^ " magic-space

# normal space during searches
bindkey -M isearch " " magic-space

# Aliases
alias bg='screen -d -m "$@"'
#alias cat='bat'
alias ch="curl cht.sh/$1"
alias k="kubectl"
alias pip=pip3
alias python=python3
alias v="nvim"
alias vi="nvim"
alias vic="cd ~/.config/nvim/lua;nvim"
alias vik="nvim ~/.config/kitty/kitty.conf"
alias vim="nvim"
alias vz="nvim ~/.zshrc"
alias workc="git log --shortstat --author=\"Kenley Bastari\" --since=\"2 weeks ago\" --until=\"1 week ago\" | grep \"files changed\" | awk '{files+=$1; inserted+=$4; deleted+=$6} END {print \"files changed\", files, \"lines inserted:\", inserted, \"lines deleted:\", deleted}'"

# git checkout interactive
alias gci='git checkout $(git branch --sort=-committerdate | head -n 5 | fzf)'

alias -g C="| pbcopy"
alias -g G="| rg"
alias -g L="| lnav"
alias -g A="| awk '{print \$1}'"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PKG_CONFIG_PATH="/usr/local/opt/libxml2/lib/pkgconfig:$PKG_CONFIG_PATH"

# pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/shims:$PATH"
# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
# fi
# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv virtualenv-init -)"
# fi

# zlib
export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include"

# direnv
eval "$(direnv hook zsh)"
export N_PREFIX="/usr/local/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

#GVM
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# emscripten
emscripten() {
 source ~/code/reVrost/emsdk/emsdk_env.sh > /dev/null 2>&1
}

# zoxide
eval "$(zoxide init zsh)"

export MISE_SHELL=zsh
export __MISE_ORIG_PATH="$PATH"

mise() {
  local command
  command="${1:-}"
  if [ "$#" = 0 ]; then
    command /opt/homebrew/bin/mise
    return
  fi
  shift

  case "$command" in
  deactivate|shell|sh)
    # if argv doesn't contains -h,--help
    if [[ ! " $@ " =~ " --help " ]] && [[ ! " $@ " =~ " -h " ]]; then
      eval "$(command /opt/homebrew/bin/mise "$command" "$@")"
      return $?
    fi
    ;;
  esac
  command /opt/homebrew/bin/mise "$command" "$@"
}

_mise_hook() {
  eval "$(/opt/homebrew/bin/mise hook-env -s zsh)";
}
typeset -ag precmd_functions;
if [[ -z "${precmd_functions[(r)_mise_hook]+1}" ]]; then
  precmd_functions=( _mise_hook ${precmd_functions[@]} )
fi
typeset -ag chpwd_functions;
if [[ -z "${chpwd_functions[(r)_mise_hook]+1}" ]]; then
  chpwd_functions=( _mise_hook ${chpwd_functions[@]} )
fi

_mise_hook
if [ -z "${_mise_cmd_not_found:-}" ]; then
    _mise_cmd_not_found=1
    [ -n "$(declare -f command_not_found_handler)" ] && eval "${$(declare -f command_not_found_handler)/command_not_found_handler/_command_not_found_handler}"

    function command_not_found_handler() {
        if /opt/homebrew/bin/mise hook-not-found -s zsh -- "$1"; then
          _mise_hook
          "$@"
        elif [ -n "$(declare -f _command_not_found_handler)" ]; then
            _command_not_found_handler "$@"
        else
            echo "zsh: command not found: $1" >&2
            return 127
        fi
    }
fi

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

clear-git-status () {
  clear
  git status
  zle reset-prompt
}
zle -N clear-git-status

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-z

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
pc() {
    aws --profile platform-nonprod-engineer sts get-caller-identity | jq
}
