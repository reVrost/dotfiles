#!/usr/bin/env bash

# install zsh
if ! command -v brew &> /dev/null
then
	# probably a ubuntu distro
	sudo apt update
	sudo apt install zsh
else
	brew install zsh
fi


# oh my zsh
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# pure prompt
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

source ~/.zshrc
