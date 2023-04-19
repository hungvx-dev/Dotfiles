#!/bin/sh
tmux rename-window $1
tmux split-window -p 17
tmux split-window -h
tmux select-pane -t 1
