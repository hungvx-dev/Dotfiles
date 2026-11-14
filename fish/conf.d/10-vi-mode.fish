if status is-interactive
    # Vi key bindings (erase the universal var so the global one always wins)
    set -g fish_key_bindings fish_vi_key_bindings
    set --erase --universal fish_key_bindings

    # Faster Esc / key-sequence handling
    set -g fish_escape_delay_ms 10
    set -g fish_sequence_key_delay_ms 200

    # Cursor shape per vi mode
    set -g fish_cursor_default block blink
    set -g fish_cursor_insert line blink
    set -g fish_cursor_replace_one underscore blink
    set -g fish_cursor_replace underscore blink
    set -g fish_cursor_visual block blink
    set -g fish_cursor_external line
end
