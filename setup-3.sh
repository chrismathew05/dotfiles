# neovim customizations
rm -rf ~/.config/nvim/
cp -r ./files/nvim/ ~/.config/nvim/

# finalize
source ~/.zshrc

# to copy paste between neovim and anywhere
# https://github.com/equalsraf/win32yank/issues/9
winget.exe install win32yank

echo "Setup complete!"
