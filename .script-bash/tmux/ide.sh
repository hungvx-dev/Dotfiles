#!/bin/sh

# Dotfiles Session
dotfilesSession="Dotfiles"
dotfilesWindow="dotfiles-nvim"
# Dotfiles nvim window
tmux new-session -d -c ~/Dev/Dotfiles -s $dotfilesSession -n $dotfilesWindow
tmux send-keys "nvim" C-m

# Lazygit window
lazygitDotfilesWindow="lazygit"
tmux new-window -c ~/Dev/Dotfiles -t $dotfilesSession:2 -n $lazygitDotfilesWindow
tmux send-keys "lazygit" C-m

tmux split-window -c ~/Dev/Dotfiles -v -p 6
tmux send-keys "cl" C-m


# AMTB session
AMTBSession="AMTB-TTHH"
AMTBWindow="Dieu-Phap"
tmux new-session -d -c ~/Dev/AMTB-TTHH -s $AMTBSession -n $AMTBWindow
tmux send-keys "cd ./DieuPhap && cl" C-m

# Learning session
learningSession="Learning"
learningDir="~/Dev/Learning"

tmux new-session -d -c ~/Dev/Learning -s $learningSession -n Vue
tmux send-keys "cd ./vue && cl" C-m

tmux new-window -c ~/Dev/Learning -t $learningSession:2 -n typescript
tmux send-keys "cd ./typescript && cl" C-m

tmux new-window -c ~/Dev/Learning -t $learningSession:3 -n backend
tmux send-keys "cd ./backend && cl" C-m

# Work Session
hodfordsSession="Hodfords"
hodfordDir="~/Work/Hodfords"
tmux new-session -c ~/Work/Hodfords -s $hodfordsSession -d
project1="project1"
# . ./tmux/create-win-project.sh $project1 "~/Work/Hodfords"
tmux rename-window $project1
tmux split-window -c ~/Work/Hodfords -v -p 6
tmux split-window -c ~/Work/Hodfords -h -p 50

tmux select-window -t $dotfilesSession:1
tmux attach-session -t $dotfilesSession
