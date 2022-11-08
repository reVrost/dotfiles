#!/usr/bin/env bash

# install zsh
if ! command -v brew &>/dev/null; then
	# probably a ubuntu distro
	sudo apt update
	sudo apt install zsh
else
	brew install zsh
fi

# oh my zsh
printf "\nInstalling oh my zsh.."
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &>/dev/null
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions &>/dev/null

# Links
printf "\nConfiguring links.."
ln -s $(pwd)/kitty ~/.config/kitty
ln -s $(pwd)/nvchad/custom ~/.config/nvim/lua/custom
mv ~/.zshrc ~/.zshrc.bak
ln $(pwd)/.zshrc ~/.zshrc
source ~/.zshrc

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# install direnv
brew install direnv
brew install neovim

# lsps
brew install lua-language-server stylua luarocks luacheck
brew install shellcheck shmft
brew install docker docker-compose

# git stuff
brew install git
brew tap microsoft/git
brew install --cask git-credential-manager-core

# pure prompt
printf "\nInstalling pure prompt.."
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

# install nvchad
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
nvim +'hi NormalFloat guibg=#1e222a' +PackerSync

# git
printf "\nConfiguring git stuff.."
git config --global credential.helper store

# FZF
printf "\nConfiguring fzf.."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

printf "\nZSH setup is done!\nMake sure to source your zshrc!"
printf "\nSet your keyboard initial repeat to max everything for vim"
