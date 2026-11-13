if not status is-interactive
    return
end

starship init fish | source
zoxide init fish --cmd j | source
