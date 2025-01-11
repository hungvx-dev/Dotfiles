set -x _ZO_ECHO 1
set -x _ZO_RESOLVE_SYMLINKS 1
zoxide init fish | source

starship init fish | source


set -x LG_CONFIG_FILE "$HOME/.config/lazygit/config.yml"
set -x STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"
set -x RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/.ripgreprc"

set fish_path $HOME/.config/fish
. $fish_path/kitty.sh
. $fish_path/alias/init.fish

set -g FZF_DEFAULT_COMMAND "fd --type=f --hidden --color=never --exclude .git"
set -g FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS \
  '
  --border="rounded"
  --color=fg:#d0d0d0,fg+:#5fd7ff,bg:-1,bg+:-1
  --color=hl:#d7005f,hl+:#d7005f,info:#afaf87,marker:#87ff00
  --bind ctrl-f:page-down,ctrl-b:page-up
  --bind ctrl-d:preview-page-down,ctrl-u:preview-page-up
  '

set -g FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -g FZF_CTRL_T_OPTS "
  --preview 'bat -n --color=always --line-range :500 {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

set -g FZF_ALT_C_COMMAND "fd --type=d --hidden --color=never --exclude .git"
set -g FZF_ALT_C_OPTS "--preview 'eza --tree --color=always --level=2 {}'"

set -g FZF_CTRL_R_OPTS "
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

fzf --fish | source
