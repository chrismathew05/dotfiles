#!/bin/bash
# Basic setup: git, python, vim, tmux, ohmyzsh, node, tldr, p10k (manual config)

# basic
sudo apt update
sudo apt install git-all -y
sudo apt-get install python3-pip -y
sudo apt-get install ripgrep -y

# vim/tmux customizations
cp ./files/.vimrc ~/.vimrc
cp ./files/.tmux.conf ~/.tmux.conf

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf

# ohmyzsh + node + tldr
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash # latest from: https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating
source ~/.zshrc
nvm install node
sudo npm install -g tldr -y

#powerlevel10k (manual)
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
source ~/.zshrc
p10k configure
