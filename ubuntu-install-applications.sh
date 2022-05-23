#!/bin/sh

sudo apt update
sudo apt install curl

## Install Nvm/node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# Install nodejs
#sudo apt intsall nodejs && node -v && npm -v
nvm list
nvm install --lts
# Install git
sudo apt install xclip
sudo apt install git && git --version
git config --global user.name "hung.vx"
git config --global user.email "hungvx.dev@gmail.com"

# IDE
#sudo apt install apt-transport-https && sudo apt update
#sudo apt install code
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt install neovim
#code --version && nvim --version
## Package neovim
sudo apt install python-neovim
sudo apt install python3-neovim
sudo apt install python3-pip
sudo apt install ripgrep
pip3 install neovim
pip3 install pynvim
npm i -g neovim
### Lsp
npm i -g vscode-langservers-extracted vscode-vue-languageservice dockerfile-language-server-nodejs graphql-language-service-cli diagnostic-languageserver
npm i -g typescript typescript-language-server vls vue-language-server @angular/language-server bash-language-server yaml-language-server

# Tools
sudo apt install tmux
sudo apt install autojump
sudo apt install fzf

# Package node - neovim
npm i -g yarn
npm i -g lite-server eslint



