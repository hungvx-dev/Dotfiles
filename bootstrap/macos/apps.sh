#!/bin/sh

brew update
brew upgrade

## Tools
brew install autojump
brew install tmux
brew install --cask kitty
brew install fzf
brew install lazygit

## Install IDE
brew install neovim
code --version && nvim --version

brew install ripgrep fb bat
pip3 --version && python3 --version
python3 -m pip install --upgrade pip
pip3 install neovim
pip3 install pynvim
yarn global add neovim

## Package node - neovim
npm install -g lite-server eslint_d typescript

## Font
brew tap homebrew/cask-fonts

## Window Manager
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd

## Music
brew install cmus
brew install cava
brew install --cask background-music

## VPN
brew install wireguard-tools

# Neovide
# brew install rustup-init
# rustup-init
# brew install cmake
# git clone https://github.com/neovide/neovide
# cd neovide
# cargo build --release
# cargo install cargo-bundle
# cargo bundle --release
# cp ./target/release/bundle/osx/neovide.app ~/Applications
