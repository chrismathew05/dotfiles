#!/bin/bash
# pulls in customizations from local computer

cp ~/.vimrc ./files/.vimrc
cp ~/.zshrc ./files/.zshrc
cp ~/.tmux.conf ./files/.tmux.conf
cp ~/.oh-my-zsh/custom/customize.zsh ./files/customize.zsh
cp -r ~/.config/nvim/ ./files/nvim/
