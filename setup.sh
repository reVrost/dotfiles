#!/usr/bin/env bash

# Function to install Homebrew if it's not already installed
install_brew() {
	if ! command -v brew &>/dev/null; then
		printf "\nInstalling Homebrew.."
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		if [[ "$OSTYPE" == "linux-gnu"* ]]; then
			eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
		else
			eval "$(/opt/homebrew/bin/brew shellenv)"
		fi
	fi
}

# Function to install packages using Homebrew
install_package() {
	brew install "$1"
}

# Install Homebrew if not already installed
install_brew

# install zsh
if ! command -v zsh &>/dev/null; then
	install_package zsh
fi

# install plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions


# install direnv and neovim
install_package direnv
install_package neovim
install_package yarn
install_package zoxide
install_package n

brew install --cask font-blex-mono-nerd-font
brew install --cask rectangle

# lsps
#install_package lua-language-server
#install_package stylua
#install_package luarocks
#install_package luacheck
#install_package shellcheck
#install_package shfmt
#install_package bat
install_package docker
install_package docker-compose

# git stuff
install_package git

# Install Git Credential Manager for Linux if brew is not available
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	curl -fsSL https://aka.ms/install-gcm.sh | bash
else
	brew tap microsoft/git
	brew install --cask git-credential-manager-core
fi

# pure prompt
printf "\nInstalling pure prompt.."
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

# install nvchad
git clone -b v2.5 https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
#nvim +'hi NormalFloat guibg=#1e222a' +PackerSync

# git
printf "\nConfiguring git credentials store.."
git config --global credential.helper store

# FZF
printf "\nConfiguring fzf.."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

printf "\nZSH setup is done!\nMake sure to source your zshrc!"
printf "\nSet your keyboard initial repeat to max everything for vim"
