#!/bin/sh

sudo apt update

# Tools
sudo apt install curl
sudo apt install tmux
sudo apt install autojump
sudo apt install fzf
sudo apt install lazygit

## Install Nvm/node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm list
nvm install --lts
nvm install v

# Install git
sudo apt install git && git --version
git config --global user.name "hung.vx"
git config --global user.email "hungvx.dev@gmail.com"
git config --global user.useConfigOnly true

# IDE
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt install neovim

## Package neovim
sudo apt install python-neovim
sudo apt install python3-neovim
sudo apt install python3-pip
sudo apt install ripgrep
pip3 install neovim
pip3 install pynvim
npm i -g yarn
yarn global add neovim

## Package node - neovim
yarn global add lite-server eslint typescript 

## Lsp
yarn global add vscode-langservers-extracted vscode-vue-languageservice dockerfile-language-server-nodejs graphql-language-service-cli typescript-language-server vls yaml-language-server diagnostic-languageserver bash-language-server
