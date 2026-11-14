if not status is-interactive
    return
end

starship init fish | source
enable_transience
function starship_transient_prompt_func
    starship module directory
    starship module character
end

zoxide init fish --cmd j | source
skim_key_bindings
