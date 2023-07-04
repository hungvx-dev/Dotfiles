#!/bin/sh

brew install fish
which fish
# Make fish the default
sudo sh -c 'echo /opt/homebrew/bin/fish >> /etc/shells'
chsh -s /opt/homebrew/bin/fish

brew install starship
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install jorgebucaran/nvm.fish
fisher install patrickf1/fzf.fish
fisher install patrickf1/colored_man_pages.fish
