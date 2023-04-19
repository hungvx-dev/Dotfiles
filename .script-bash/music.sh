#!/bin/sh
tmux rename-window music
pkill -9 cmus
# cmus
tmux split-window -p 50
tmux select-pane -t 2
cava
