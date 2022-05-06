#!/bin/sh

sudo apt update
sudo apt install curl

## Install Nvm/node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
# Install nodejs
sudo apt intsall nodejs && node -v && npm -v
nvim list

# Install git
sudo apt install xclip
sudo apt install git && git --version
git config --global user.name "hung.vx"
git config --global user.email "hungvx.dev@gmail.com"

# IDE
sudo apt install apt-transport-https && sudo apt update
sudo apt install code
sudo apt install neovim
code --version && nvim --version
## Package neovim
sudo apt install python-neovim
sudo apt install python3-neovim
sudo apt install python3-pip
sudo apt install ripgrep
pip3 install neovim
pip3 install pynvim
npm i -g neovim
### Lsp
npm i -g vscode-langservers-extracted dockerfile-language-server-nodejs graphql-language-service-cli
npm i -g typescript typescript-language-server vls @angular/language-server diagnostic-languageserver
yarn global add yaml-language-server

# Tools
sudo apt install tmux
sudo apt install autojump

# Package node - neovim
npm i -g yarn typescript
npm install -g lite-server eslint 



