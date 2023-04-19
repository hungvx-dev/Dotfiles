#!/bin/sh
tmux rename-window Dotfiles
cd $(autojump Dotfiles)
nvim
