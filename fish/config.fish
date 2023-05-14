set -x LANG en_US.UTF-8
set -gx EDITOR nvim
set -gx NVM_DIR $HOME/.nvm

set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

fish_vi_key_bindings

set fish_path $HOME/.config/fish
. $fish_path/alias/my_alias.fish
. $fish_path/alias/git_alias.fish

starship init fish | source

[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

# # pnpm
set -gx PNPM_HOME "/Users/hungvx.dev/Library/pnpm"
set fish_user_paths $fish_user_paths $PNPM_HOME
# # pnpm end

# ruby
set -gx GEM_HOME $HOME/.gem
set -gx RUBY_PATH /opt/homebrew/opt/ruby/bin
set fish_user_paths $fish_user_paths $RUBY_PATH
set fish_user_paths $fish_user_paths $GEM_HOME/bin
# ruby end

# Sed
set fish_user_paths $fish_user_paths /opt/homebrew/opt/gnu-sed/libexec/gnubin
