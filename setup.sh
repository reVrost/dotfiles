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


# git 
install_package git
# install others
install_package direnv
install_package neovim
install_package zoxide
install_package mise
install_package rg
install_package bat
install_package docker
install_package docker-compose

brew install --cask font-blex-mono-nerd-font
brew install --cask rectangle

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

# git
printf "\nConfiguring git credentials store.."
git config --global credential.helper store

# FZF
printf "\nConfiguring fzf.."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

printf "\nZSH setup is done!\nMake sure to source your zshrc!"
printf "\nSet your keyboard initial repeat to max everything for vim"
