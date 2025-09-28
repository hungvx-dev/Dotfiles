set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

if status is-interactive
    fish_vi_key_bindings
    # Commands to run in interactive sessions can go here
    set fish_cursor_default block blink
    set fish_cursor_insert line blink
    set fish_cursor_replace_one underscore blink
    set fish_cursor_replace underscore blink
    # set fish_cursor_external line blink
    set fish_cursor_visual block blink
    # set -g fish_vi_force_cursor 1
end

set -g EDITOR nvim

set fish_path $HOME/.config/fish
. $fish_path/alias/init.fish
. $fish_path/sk.fish
. $fish_path/env.fish
# . $fish_path/kitty.sh
# . $fish_path/fzf.fish

zoxide init fish --cmd j | source
starship init fish | source
