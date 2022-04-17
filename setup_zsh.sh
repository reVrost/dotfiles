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
printf "\nInstalling oh my zsh.."
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &> /dev/null
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions &> /dev/null

# pure prompt
printf "\nInstalling pure prompt.."
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

# git
printf "\nConfiguring git stuff.."
git config --global credential.helper store

# Links
printf "\nConfiguring links.."
ln -s $(pwd)/nvchad/custom ~/.config/nvim/lua/custom
ln $(pwd)/.zshrc ~/.zshrc

# FZF
printf "\nConfiguring fzf.."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install


printf "\nZSH setup is done!\nMake sure to source your zshrc!"
