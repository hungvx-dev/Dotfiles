set -xg SKIM_DEFAULT_COMMAND 'fd --type=f --hidden --color=never --exclude .git'
#
set -xg SKIM_DEFAULT_OPTIONS $SKIM_DEFAULT_OPTIONS \ "
  --ansi
  --color=fg:#fff8f0,matched:#FF0F80,matched_bg:-1,current_match:#FF0F80,current_match_bg:-1,current:#5fd7ff,current_bg:-1,border:#00ffff
  --bind ctrl-f:page-down,ctrl-b:page-up
  --bind ctrl-d:preview-page-down,ctrl-u:preview-page-up
"

set -xg SKIM_CTRL_T_COMMAND $SKIM_DEFAULT_COMMAND
set -xg SKIM_CTRL_T_OPTS "
  --prompt ' '
  --layout='default'
  --preview 'bat --color=always --style=numbers --line-range=:500 {}'
  "

set -xg SKIM_ALT_C_COMMAND "fd --type=d --hidden --color=never --exclude .git"
set -xg SKIM_ALT_C_OPTS "--preview 'eza --tree --color=always --level=2 {}'"

set -gx SKIM_CTRL_R_OPTS "
  --layout='default'
"

sk --shell fish | source
skim_key_bindings
