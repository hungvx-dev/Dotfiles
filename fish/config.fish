set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

set -gx EDITOR nvim

### Vi key mode
fish_vi_key_bindings
set fish_cursor_default block blink
set fish_cursor_insert line blink
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
set fish_cursor_external line
set fish_cursor_visual block

### starship
starship init fish | source

### fzf
# fzf --fish | source
### End fzf

### Run alias
set fish_path $HOME/.config/fish
. $fish_path/alias/init.fish
. $fish_path/functions.fish
. $fish_path/tokyonight_night.fish

### zoxide
set -x _ZO_ECHO 1
set -x _ZO_RESOLVE_SYMLINKS 1
zoxide init fish | source
# end

# set -gx AUTO_JUMP_SHARE_PATH /opt/homebrew/share/autojump/autojump.fish
# [ -f $AUTO_JUMP_SHARE_PATH ]; and source $AUTO_JUMP_SHARE_PATH

# ruby
set -gx GEM_HOME $HOME/.gem
set -gx RUBY_PATH /opt/homebrew/opt/ruby/bin
set fish_user_paths $fish_user_paths $RUBY_PATH
set fish_user_paths $fish_user_paths $GEM_HOME/bin
set fish_user_paths $fish_user_paths /opt/homebrew/sbin
# ruby end

### gnu-sed
set fish_user_paths $fish_user_paths /opt/homebrew/opt/gnu-sed/libexec/gnubin
if test -f $fish_path/variables.private.fish
    . $fish_path/variables.private.fish
end
# end

### lazy git
set -gx LG_CONFIG_FILE "$HOME/.config/lazygit/config.yml"
# end

### python
pyenv init - | source
# end

### pnpm
# set -gx PNPM_HOME "/Users/hungvx.dev/Library/pnpm"
# if not string match -q -- $PNPM_HOME $PATH
#     set -gx PATH "$PNPM_HOME" $PATH
# end
### pnpm end

### gcloud
source "$(brew --prefix)/share/google-cloud-sdk/path.fish.inc"
### end

### Tmux
set -Ux fish_tmux_autostart false
set -Ux fish_tmux_autostart_once false
set -Ux fish_tmux_config $HOME/.config/tmux/tmux.conf
###
