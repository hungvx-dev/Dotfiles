#!/bin/sh

# Terminal & Tmux config
rm -rf ~/.config/kitty
rm -rf ~/.config/tmux
ln -s $(pwd)/kitty ~/.config
ln -s $(pwd)/tmux ~/.config
# ln -s $(pwd)/alacritty ~/.config/alacritty
# ln -s $(pwd)/.tmux/.tmux.conf.local ~/.tmux.conf.local
# ln -s $(pwd)/.tmux/.tmux.conf ~/.tmux.conf

# Fish
rm -rf ~/.config/fish
rm -f ~/.config/starship.toml
ln -s $(pwd)/fish ~/.config/fish
ln -s $(pwd)/starship/starship.toml ~/.config/starship.toml

# Window management: Yabai + skhd
rm -rf ~/.config/yabai
rm -rf ~/.config/skhd
ln -s $(pwd)/yabai ~/.config
ln -s $(pwd)/skhd ~/.config

# Nvim config
rm -rf ~/.config/nvim
# ln -s $(pwd)/nvim ~/.config/nvim
ln -s $(pwd)/neovim ~/.config/nvim

# ZSH config
# ln -s $(pwd)/zsh ~/.config/zsh
# ln -s $(pwd)/zsh/history ~/.cache/zsh/history

# Script
rm -rf ~/.script-bash
ln -s $(pwd)/.script-bash ~/.script-bash

# Exercism
rm -rf ~/.config/exercism
ln -s $(pwd)/exercism ~/.config

# Cava
rm -rf ~/.config/cava
ln -s $(pwd)/cava ~/.config

# Git config
rm -rf ~/config/ssh
rm -rf ~/config/lazygit
ln -s $(pwd)/ssh/config ~/.ssh/config
ln -s $(pwd)/git/me/ ~/.config/git
ln -s ~/.config/git/.gitconfig ~/.config/git/config
ln -s $(pwd)/git/work/ ~/Work/Hodfords/git
ln -s $(pwd)/lazygit ~/.config

# Btop
ln -s $(pwd)/btop ~/.config

# Bat
ln -s $(pwd)/bat ~/.config

# Alias
# ln -s $(pwd)/my-alias.zsh ~/.oh-my-zsh/custom/my-alias.zsh
