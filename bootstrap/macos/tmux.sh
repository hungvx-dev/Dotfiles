#!/bin/sh

brew install tmux
which tic

# run at root this folder.
/usr/bin/tic -xe tmux-256color terminfo.src

echo "Check true color \n"
tmux info | grep -e RGB -e Tc
