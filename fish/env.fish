set -gx _ZO_DATA_DIR "$HOME/Dev/Dotfiles/zoxide"
set -gx _ZO_ECHO 1
set -gx _ZO_RESOLVE_SYMLINKS 1

set -x LG_CONFIG_FILE "$HOME/.config/lazygit/config.yml"
set -x STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"
set -x RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/.ripgreprc"
set -x TEALDEER_CONFIG_DIR $HOME/.config/tealdeer

set -gx VOLTA_HOME $HOME/.volta
set -gx PATH $VOLTA_HOME/bin $PATH
