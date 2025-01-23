if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_cursor_default block blink
    set fish_cursor_insert line blink
    set fish_cursor_replace_one underscore blink
    set fish_cursor_replace underscore blink
    set fish_cursor_external line blink
    set fish_cursor_visual block blink
    set -g fish_vi_force_cursor 1
end

set fish_path $HOME/.config/fish
# . $fish_path/kitty.sh
. $fish_path/alias/init.fish

set -gx _ZO_DATA_DIR "$HOME/Dev/Dotfiles/zoxide"
set -gx _ZO_ECHO 1
set -gx _ZO_RESOLVE_SYMLINKS 1
zoxide init fish --cmd j | source

starship init fish | source

set -x LG_CONFIG_FILE "$HOME/.config/lazygit/config.yml"
set -x STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"
set -x RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/.ripgreprc"

set -g FZF_DEFAULT_COMMAND "fd --type=f --hidden --color=never --exclude .git"
set -g FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS \
    '
  --border="rounded"
  --color=fg:#545c7e,fg+:#5fd7ff,bg:-1,bg+:-1
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

set -g EDITOR nvim
