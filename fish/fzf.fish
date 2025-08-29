set -xg FZF_DEFAULT_COMMAND "fd --type=f --hidden --color=never --exclude .git"
set -xg FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS \
    '
  --border="rounded"
  --layout="default"
  --color=fg:#fff8f0,fg+:#5fd7ff:underline:bold,bg:-1,bg+:-1
  --color=hl:#d7005f,hl+:#d7005f,info:#fff8f0,marker:#87ff00,pointer:#5fd7ff
  --bind ctrl-f:page-down,ctrl-b:page-up
  --bind ctrl-d:preview-page-down,ctrl-u:preview-page-up
  '

set -xg FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -xg FZF_CTRL_T_OPTS "
  --layout='default'
  --preview 'bat --color=always --style=numbers --line-range=:500 {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
  "

set -xg FZF_ALT_C_COMMAND "fd --type=d --hidden --color=never --exclude .git"
set -xg FZF_ALT_C_OPTS "--preview 'eza --tree --color=always --level=2 {}'"

set -g FZF_CTRL_R_OPTS "
  --layout='default'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'
  "

fzf --fish | source
