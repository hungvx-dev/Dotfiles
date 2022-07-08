!/bin/sh

brew update

## Tools
brew install autojump
brew install tmux
brew install fzf
sudo apt install lazygit

## Install Nvm/node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
## Install nodejs
brew install node && node -v && npm -v
nvm list

## Install git
brew install git && git --version
git config --global user.name "hung.vx"
git config --global user.email "hungvx.dev@gmail.com"

## Install IDE
brew install --cask visual-studio-code
brew install neovim
code --version && nvim --version

brew install ripgrep
pip3 --version && python3 --version
python3 -m pip install --upgrade pip
pip3 install neovim
pip3 install pynvim
npm i -g neovim

## Package node - neovim
npm i -g yarn
npm install -g lite-server eslint

## Lsp
npm i -g vscode-langservers-extracted dockerfile-language-server-nodejs graphql-language-service-cli
npm i -g typescript typescript-language-server vls @angular/language-server
yarn global add yaml-language-server

# Neovide
brew install rustup-init
rustup-init
brew install cmake
git clone https://github.com/neovide/neovide
# cd neovide
# cargo build --release
# cargo install cargo-bundle
# cargo bundle --release
# cp ./target/release/bundle/osx/neovide.app ~/Applications
