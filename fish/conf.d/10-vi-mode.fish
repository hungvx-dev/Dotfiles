status is-interactive; or return

set -g fish_key_bindings fish_vi_key_bindings
set --erase --universal fish_key_bindings

set -g fish_cursor_default block blink
set -g fish_cursor_insert line blink
set -g fish_cursor_replace_one underscore blink
set -g fish_cursor_replace underscore blink
set -g fish_cursor_visual block blink
