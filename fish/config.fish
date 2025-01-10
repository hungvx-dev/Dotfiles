set -x _ZO_ECHO 1
set -x _ZO_RESOLVE_SYMLINKS 1
zoxide init fish | source

starship init fish | source

set -x LG_CONFIG_FILE "$HOME/.config/lazygit/config.yml"
set -x STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"
set -x RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/.ripgreprc"

set fish_path $HOME/.config/fish
. $fish_path/kitty.sh
. $fish_path/alias/init.fish
