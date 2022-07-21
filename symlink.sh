# Terminal & Tmux config
ln -s $(pwd)/alacritty ~/.config/alacritty
ln -s $(pwd)/.tmux/.tmux.conf.local ~/.tmux.conf.local
ln -s $(pwd)/.tmux/.tmux.conf ~/.tmux.conf

# Nvim config
ln -s $(pwd)/nvim ~/.config/nvim

# ZSH config
ln -s $(pwd)/zsh ~/.config/zsh
ln -s $(pwd)/zsh/history ~/.cache/zsh/history

# Git config
rm -rf ~/config/ssh
rm -f ~/config/lazygit
rm -f ~/.gitconfig
ln -s $(pwd)/ssh ~/.config/ssh
ln -s $(pwd)/.gitconfig ~/.gitconfig
ln -s $(pwd)/lazygit/config.yml ~/.config/lazygit/config.yml

# Script
ln -s $(pwd)/.script-bash ~/.script-bash

# Alias
ln -s $(pwd)/my-alias.zsh ~/.oh-my-zsh/custom/my-alias.zsh
