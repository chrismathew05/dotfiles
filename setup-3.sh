# neovim customizations
rm -rf ~/.config/nvim/
cp -r ./files/nvim/ ~/.config/nvim/

# finalize
source ~/.zshrc

# to copy paste between neovim and anywhere
# https://github.com/equalsraf/win32yank/issues/9
winget.exe install win32yank

# llm setup - https://github.com/simonw/llm
pip install uv
uv tool install llm
llm install llm-gemini

echo "Setup complete!"
