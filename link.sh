# Links
printf "\nConfiguring links.."
# move existing kitty conf
mv ~/.config/kitty ~/.config/kitty_bak
ln -s $(pwd)/kitty ~/.config

#mv ~/.config/nvim/lua/custom ~/.config/nvim/lua/custom_bak
#ln -s $(pwd)/nvchad/custom ~/.config/nvim/lua/custom

mv ~/.config/nvim ~/.config/nvim_bak
ln -s $(pwd)/nvim ~/.config

mv ~/.zshrc ~/.zshrc.bak
ln -s $(pwd)/.zshrc ~/.zshrc
ln -s $(pwd)/custom ~/.zsh/custom
source ~/.zshrc
ln -s $(pwd)/themes/ghostly.lua ~/.local/share/nvim/lazy/base46/lua/base46/themes/ghostly.lua
