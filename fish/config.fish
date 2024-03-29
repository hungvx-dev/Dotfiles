set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

set -gx EDITOR nvim
set -gx NVM_DIR $HOME/.nvm

### Vi key mode
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block
fish_vi_key_bindings

### starship
starship init fish | source

### Run alias
set fish_path $HOME/.config/fish
. $fish_path/alias/my_alias.fish
. $fish_path/alias/git_alias.fish
. $fish_path/tokyonight_night.fish
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

### pnpm
# set -gx PNPM_HOME "/Users/hungvx.dev/Library/pnpm"
# if not string match -q -- $PNPM_HOME $PATH
#     set -gx PATH "$PNPM_HOME" $PATH
# end
# end

### lazy git
set -gx LG_CONFIG_FILE "$HOME/.config/lazygit/config.yml"
# end

### fnm
# set -gx PATH "/Users/hungvx.dev/Library/Caches/fnm_multishells/48126_1700281069680/bin" $PATH
# set -gx FNM_MULTISHELL_PATH "/Users/hungvx.dev/Library/Caches/fnm_multishells/48126_1700281069680"
# set -gx FNM_VERSION_FILE_STRATEGY local
# set -gx FNM_RESOLVE_ENGINES false
# set -gx FNM_LOGLEVEL info
# set -gx FNM_NODE_DIST_MIRROR "https://nodejs.org/dist"
# set -gx FNM_DIR "/Users/hungvx.dev/Library/Application Support/fnm"
# set -gx FNM_ARCH arm64
# set -gx FNM_COREPACK_ENABLED false
# # end
