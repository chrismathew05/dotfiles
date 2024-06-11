#!/bin/bash
# Remaining setup: zsh customization, neovim

# autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# zsh customizations
cp ./files/.zshrc ~/.zshrc
cp ./files/customize.zsh ~/.oh-my-zsh/custom/customize.zsh

# neovim - https://github.com/neovim/neovim/blob/master/BUILD.md
sudo apt-get install ninja-build gettext cmake unzip curl build-essential
git clone https://github.com/neovim/neovim ~/
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

# to update neovim
cd ~/neovim
git pull
sudo make install

# neovim customizations
rm -rf ~/.config/nvim/
cp -r ./files/nvim/ ~/.config/nvim/

# finalize
source ~/.zshrc

# to copy paste between neovim and anywhere
# https://github.com/equalsraf/win32yank/issues/9
winget.exe install win32yank

echo "Setup complete!"
