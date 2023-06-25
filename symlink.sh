#!/bin/sh

# Terminal & Tmux config
rm -rf ~/.config/kitty
rm -rf ~/.config/tmux
ln -s $(pwd)/kitty ~/.config/kitty
ln -s $(pwd)/tmux ~/.config/tmux
# ln -s $(pwd)/alacritty ~/.config/alacritty
# ln -s $(pwd)/.tmux/.tmux.conf.local ~/.tmux.conf.local
# ln -s $(pwd)/.tmux/.tmux.conf ~/.tmux.conf

# FISh
rm -rf ~/.config/fish
rm -f ~/.config/starship.toml
ln -s $(pwd)/fish ~/.config/fish
ln -s $(pwd)/starship/starship.toml ~/.config/starship.toml

# Window management: Yabai + skhd
rm -rf ~/.config/yabai
rm -rf ~/.config/skhd
ln -s $(pwd)/yabai ~/.config/yabai
ln -s $(pwd)/skhd ~/.config/skhd

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
ln -s $(pwd)/exercism ~/.config/exercism

# Cava
rm -rf ~/.config/cava
ln -s $(pwd)/cava ~/.config/cava

# Git config
rm -rf ~/config/ssh
rm -rf ~/config/lazygit
ln -s $(pwd)/ssh/config ~/.ssh/config
ln -s $(pwd)/ssh/.gitconfig ~/.gitconfig
ln -s $(pwd)/ssh/work/.gitconfig ~/Work/Hodfords/.gitconfig
ln -s $(pwd)/lazygit/config.yml ~/.config/lazygit/config.yml

# Alias
# ln -s $(pwd)/my-alias.zsh ~/.oh-my-zsh/custom/my-alias.zsh

