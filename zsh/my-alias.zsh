# ls
alias l='ls -Flh'
alias ll='ls -Flha'
 
# verbose
alias mkdir='mkdir -v'
alias rmdir='rmdir -v'
alias cl='clear'
alias ex='exit'

# git
alias gs='git status -s'
alias gS='git status'
alias gc='git commit -m'
alias gac='git add . && git commit -m'
alias gcdp='git checkout $(git_develop_branch) && git pull origin $(git_develop_branch)'
alias gcmp='git checkout $(git_main_branch) && git pull origin $(git_main_branch)'
alias gl='git log --graph --stat --oneline --decorate --source --pretty=format:"%Cblue %h %C(bold red)- <%an> -%C(green) (%ar)%C(auto)%d%n%C(yellow) %s"'
alias gla='git log --all --graph --stat --oneline --decorate --source --pretty=format:"%Cblue %h %C(bold red)- <%an> -%C(green) (%ar)%C(auto)%d%n%C(yellow) %s"'
alias lz="lazygit"
 
# tmux
# alias tmux='tmux -f $HOME/.config/tmux/tmux.conf'
alias t='tmux'
alias ta='tmux attach'
alias trw='tmux rename-window'
alias trs='tmux rename-session'
 
# nvim
alias nv='nvim'
alias v='vim'  
 
# npm
alias ni='npm install'
alias ns='npm start'  
alias nt='npm test' 
alias nb='npm build'
alias nr='npm run'
alias nrd='nr dev'

# yarn
alias ya='yarn add'
alias yi='yarn install'
alias yad='yarn add -D'
alias ys='yarn start'  
alias yt='yarn test' 
alias yb='yarn build'
alias yd='yarn dev'
alias yr='yarn remove'

# docker
alias dcu='docker-compose up'
alias dcub='docker-compose up --build'
alias dcd='docker-compose up -d'

# command script shell
alias ide='~/.script-bash/.ide.sh'
alias dfs='~/.script-bash/.attach-nvim.sh Dotfile'
