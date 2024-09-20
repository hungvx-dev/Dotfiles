#!/bin/sh

# ------------------------------ Dotfiles Session ------------------------------
DotfilesSession="Dotfiles"
# ------------------- Dotfiles nvim window
DotfilesWindow="Dotfiles_Nvim"
tmux new-session -d -c ~/Dev/Dotfiles -s $DotfilesSession -n $DotfilesWindow
tmux send-keys "nvim" C-m
# ------------------- Lazygit window
LazygitDotfilesWindow="Lazygit"
tmux new-window -c ~/Dev/Dotfiles -t $DotfilesSession:2 -n $LazygitDotfilesWindow
tmux send-keys "TERM=xterm-kitty lazygit" C-m
# ------------------- Git Panel
Git="Git"
tmux split-window -c ~/Dev/Dotfiles -v -l 20%
tmux send-keys "cl" C-m

# ----------------------------- Music Session ----------------------------------
MusicSession="Music"
# ------------------- Cmus window
CmusWindow="Cmus"
tmux new-session -d -s $MusicSession -n $CmusWindow
tmux send-keys "cmus && cl" C-m

# ---------------------------- Learning Session --------------------------------
LearningSession="Learning"
# ------------------- Front-end Window
tmux new-session -d -c ~/Dev/Learning -s $LearningSession -n Front-end
tmux send-keys "cd ./front-end && cl" C-m
# ------------------- Back-end Window
tmux new-window -c ~/Dev/Learning -t $LearningSession:2 -n Back-end
tmux send-keys "cd ./back-end && cl" C-m
# ------------------- Devops Window
tmux new-window -c ~/Dev/Learning -t $LearningSession:3 -n Devops
tmux send-keys "cd ./devops && cl" C-m
# ------------------------------ Works Session ---------------------------------
WorkSession="Works"
tmux new-session -d -c ~/Work -s $WorkSession -n Work

# ------------------- Select Session -----------------------
tmux attach-session -t $DotfilesSession
tmux select-window -t $DotfilesSession:1

# # AMTB session
# AMTBSession="AMTB-TTHH"
# AMTBWindow="Dieu-Phap"
# tmux new-session -d -c ~/Dev/AMTB-TTHH -s $AMTBSession -n $AMTBWindow
# tmux send-keys "cd ./DieuPhap && cl" C-m

# project1="project1"
# # . ./tmux/create-win-project.sh $project1 "~/Work/Hodfords"
# tmux rename-window $project1
# tmux split-window -c ~/Work/Hodfords -v -p 6
# tmux split-window -c ~/Work/Hodfords -h -p 50
