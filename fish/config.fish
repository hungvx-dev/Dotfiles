set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

set -gx EDITOR nvim
set -gx NVM_DIR $HOME/.nvm

set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

fish_vi_key_bindings

# Run alias
set fish_path $HOME/.config/fish
. $fish_path/alias/my_alias.fish
. $fish_path/alias/git_alias.fish
. $fish_path/tokyonight_night.fish

starship init fish | source

# zoxide
set -x _ZO_ECHO '1'
zoxide init fish | source

# set -gx AUTO_JUMP_SHARE_PATH /opt/homebrew/share/autojump/autojump.fish
# [ -f $AUTO_JUMP_SHARE_PATH ]; and source $AUTO_JUMP_SHARE_PATH

# ruby
set -gx GEM_HOME $HOME/.gem
set -gx RUBY_PATH /opt/homebrew/opt/ruby/bin
set fish_user_paths $fish_user_paths $RUBY_PATH
set fish_user_paths $fish_user_paths $GEM_HOME/bin
set fish_user_paths $fish_user_paths /opt/homebrew/sbin
# ruby end

# gnu-sed
set fish_user_paths $fish_user_paths /opt/homebrew/opt/gnu-sed/libexec/gnubin

. $fish_path/variables.private.fish

# pnpm
set -gx PNPM_HOME "/Users/hungvx.dev/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

