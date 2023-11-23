#!/bin/sh

brew install fish
which fish
# Make fish the default
sudo sh -c 'echo $(which fish) >> /etc/shells'
chsh -s $(which fish)

brew install starship
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install patrickf1/fzf.fish
fisher install patrickf1/colored_man_pages.fish
fisher install kidonng/zoxide.fish
