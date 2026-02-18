# zmodload zsh/zprof

# zshload optimizations

# Limit fpath to reduce compinit scan time
# fpath=(~/.zsh/completions $fpath)


# Minimize compaudit calls and enable completion caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zcompdump


# Starts
export PATH="$PATH:$HOME/go/bin:$HOME/bin:/usr/local/bin:/usr/local/go/bin:/usr/local/lua-language-server/bin:/opt/homebrew/bin:$HOME/.local/bin:$HOME/.local/share/mise/shims"

# Path to your oh-my-zsh installation.
# export ZSH="$HOME/.oh-my-zsh"

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
# zstyle :prompt:pure:git:stash show yes

# ZSHRC plugin
# source $ZSH/oh-my-zsh.sh
autoload -Uz compinit
# Regenerate if no dump or dump is older than 24 hours
if [[ -f ~/.zcompdump && $(stat -f %m ~/.zcompdump 2>/dev/null) -ge $(( $(date +%s) - 24*60*60 )) ]]; then
    compinit -C  # Load from cache without checking
else
    compinit     # Regenerate cache
fi
# Clean up old zcompdump files to prevent accumulation
if [[ -f ~/.zcompdump && $(stat -f %m ~/.zcompdump 2>/dev/null) -lt $(( $(date +%s) - 24*60*60 )) ]]; then
    rm -f ~/.zcompdump*(N) 2>/dev/null
fi
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
alias codex="codex --yolo"
alias ssh="kitty +kitten ssh"
alias bg='screen -d -m "$@"'
alias ch="curl cht.sh/$1"
alias pip=pip3
alias python=python3
alias v="nvim"
alias vi="nvim"
alias vic="cd ~/.config/nvim/lua;nvim"
alias vik="nvim ~/.config/kitty/kitty.conf"
alias vim="nvim"
alias vz="nvim ~/.zshrc"
alias jtug='jj tug && jj git push'

# git checkout interactive
alias gci='git checkout $(git branch --sort=-committerdate | head -n 5 | fzf)'

alias -g C="| pbcopy"
alias -g G="| rg"
alias -g L="| lnav"
alias -g A="| awk '{print \$1}'"


export PKG_CONFIG_PATH="/usr/local/opt/libxml2/lib/pkgconfig:$PKG_CONFIG_PATH"

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

# allow drag by ctrl+cmd
defaults write -g NSWindowShouldDragOnGesture YES


# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

gwi() {
  if ! command -v fzf &> /dev/null; then
    echo "Error: 'fzf' is not installed."
    return 1
  fi

  local choice
  choice=$(printf "List existing\nAdd new" | fzf --prompt="Worktree action: ")

  if [[ $choice == "List existing" ]]; then
    local dir
    dir=$(git worktree list --porcelain | awk '/worktree /{print $2}' | fzf --prompt="Select worktree: ")
    [ -n "$dir" ] && cd "$dir"

  elif [[ $choice == "Add new" ]]; then
    local base branch newdir

    base=$(git branch --sort=-committerdate | sed 's/^[* ]*//' | fzf --prompt="Base branch: ")
    [ -z "$base" ] && echo "No base branch selected. Exiting." && return

    # Zsh compatible read syntax
    printf "New branch name: "
    read branch
    [ -z "$branch" ] && echo "No branch name entered. Exiting." && return

    # Get the parent directory of the current git repo
    local repo_parent
    repo_parent=$(dirname "$(git rev-parse --show-toplevel)")
    newdir="$repo_parent/${branch//\//-}"

    if [[ -d "$newdir" ]]; then
      echo "Error: Directory '$newdir' already exists."
      return 1
    fi

    if git rev-parse --verify "$branch" >/dev/null 2>&1; then
      echo "Error: Branch '$branch' already exists."
      return 1
    fi

    echo "Creating worktree in $newdir..."
    git worktree add -b "$branch" "$newdir" "$base" && cd "$newdir"
  fi
}


workc() {
  git log --shortstat \
    --author="Kenley Bastari" \
    --since="2 weeks ago" \
    --until="1 week ago" |
  grep "files changed" |
  awk '{files+=$1; inserted+=$4; deleted+=$6} END {print "files changed", files, "lines inserted:", inserted, "lines deleted:", deleted}'
}

gol() {
  golangci-lint run --fix
}

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

hexeth() {
    # Check if an argument was provided
    if [[ $# -eq 0 ]]; then
        echo "Usage: hexeth <hex_value>"
        echo "Example: hexeth 0xd31d95881a4a3116"
        return 1
    fi
  # Remove 0x prefix if present
    local hex_value="${1#0x}"

    # Use Python for precise conversion
    python3 -c "
hex_value = '0x$hex_value'
eth_value = int(hex_value, 16) / (10**18)
print(f'{eth_value:.4f} ETH')
"
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

# @ fuzzy file search — type @ to search files inline (like agentic coding tools)
_at_file_search() {
  local selected
  selected=$( (fd --type f --hidden --exclude .git 2>/dev/null || find . -type f -not -path '*/.git/*' | sed 's|^\./||') | fzf --height=40% --reverse --border --prompt="@ " )

  if [[ -n "$selected" ]]; then
    LBUFFER+="$selected"
  else
    LBUFFER+="@"
  fi
  zle reset-prompt
}
zle -N _at_file_search
bindkey '@' _at_file_search

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
kprod() {
    echo "might need: aws sso login"
    aws --profile platform-prod-engineer sts get-caller-identity | jq
    aws --profile platform-prod-engineer eks update-kubeconfig --name prod --region us-east-2 --alias prod
    kubectl config set-context --current --namespace=prod
}
pc() {
    aws --profile platform-nonprod-engineer sts get-caller-identity | jq
}
ai() {
  # Check if a query is provided
  if [ -z "$1" ]; then
    echo "Usage: ai <your query>"
    return 1
  fi

  # Your OpenRouter API key (set as env variable or replace here)
  API_KEY=${OPENROUTER_API_KEY:-"your-api-key-here"}

  # API endpoint for OpenRouter
  API_URL="https://openrouter.ai/api/v1/chat/completions"

  # The query from command line arguments
  QUERY="$@"

  # JSON payload for the API request
  PAYLOAD=$(jq -n \
    --arg model "google/gemini-2.5-flash-preview" \
    --arg query "$QUERY" \
    '{
      model: $model,
      messages: [
        {
          role: "user",
          content: $query
        }
      ]
    }')

  # Make the curl request to OpenRouter API
  RESPONSE=$(curl -s -X POST "$API_URL" \
    -H "Authorization: Bearer $API_KEY" \
    -H "Content-Type: application/json" \
    -d "$PAYLOAD")

  # Check if the response contains an error
  if echo "$RESPONSE" | jq -e '.error' >/dev/null; then
    echo "Error: $(echo "$RESPONSE" | jq -r '.error.message')"
    return 1
  fi

  # Extract and print the response content
  echo "$RESPONSE" | jq -r '.choices[0].message.content'
}
# zprof
#
if [ -f ~/.zshrc.local ]; then
    . ~/.zshrc.local
fi

# Log colorizer - pipe logs through this
# Usage: tail -f app.log | logc
logc() {
  sed -E \
    -e "s/(INFO)/${fg[blue]}\1${reset_color}/gi" \
    -e "s/(DEBUG)/${fg[white]}\1${reset_color}/gi" \
    -e "s/(WARN(ING)?)/${fg[yellow]}\1${reset_color}/gi" \
    -e "s/(ERROR)/${fg[red]}\1${reset_color}/gi"
}

# opencode
export PATH=/Users/kenley/.opencode/bin:$PATH
eval "$(mise activate zsh)"

# Added by Antigravity
export PATH="/Users/revrost/.antigravity/antigravity/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kenley.bastari/Downloads/google-cloud-sdk 2/path.zsh.inc' ]; then . '/Users/kenley.bastari/Downloads/google-cloud-sdk 2/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kenley.bastari/Downloads/google-cloud-sdk 2/completion.zsh.inc' ]; then . '/Users/kenley.bastari/Downloads/google-cloud-sdk 2/completion.zsh.inc'; fi
source <(kubectl completion zsh)
