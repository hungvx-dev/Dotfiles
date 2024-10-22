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

ln -s $(pwd)/aerospace ~/.config

# Nvim config
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
ln -s $(pwd)/nvim ~/.config/nvim

ln -s $(pwd)/ideavim ~/.config
ln -s ~/.config/ideavim/.ideavimrc ~/.config/ideavim/ideavimrc

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
ln -s $(pwd)/cmus/tokyo.theme ~/.config/cmus/tokyo.theme

# Git config
rm -rf ~/.config/ssh
rm -rf ~/.config/lazygit
ln -s $(pwd)/ssh/config ~/.ssh/config
ln -s $(pwd)/git/me/ ~/.config/git
ln -s ~/.config/git/.gitconfig ~/.config/git/config
ln -s $(pwd)/git/work/ ~/Work/Hodfords/git
ln -s $(pwd)/lazygit ~/.config
ln -s $(pwd)/gitui ~/.config

# Btop
rm -rf ~/.config/btop
ln -s $(pwd)/btop ~/.config

# Bat
rm -rf ~/.config/bat
ln -s $(pwd)/bat ~/.config

# Karabiner-Elements
rm -rf ~/.config/karabiner
ln -s $(pwd)/karabiner ~/.config

# Raycast
rm -rf ~/.config/raycast
ln -s $(pwd)/raycast ~/.config

# Alias
# ln -s $(pwd)/my-alias.zsh ~/.oh-my-zsh/custom/my-alias.zsh
