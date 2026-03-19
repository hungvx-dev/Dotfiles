set -gx EDITOR "nvim -f"
# set -Ux EDITOR "nvim -f"

# zoxide
set -Ux _ZO_DATA_DIR "$HOME/Dev/Dotfiles/zoxide"
set -Ux _ZO_ECHO 1
set -Ux _ZO_RESOLVE_SYMLINKS 1

# lazygit, starship, ripgrep, tealdeer
set -gx LG_CONFIG_FILE "$HOME/.config/lazygit/config.yml"
set -gx STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"
set -gx RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/.ripgreprc"
set -gx TEALDEER_CONFIG_DIR "$HOME/.config/tealdeer"

# volta
# set -gx VOLTA_HOME "$HOME/.volta"
# set -gx PATH $VOLTA_HOME/bin $PATH
# set -gx VOLTA_FEATURE_PNPM 1
