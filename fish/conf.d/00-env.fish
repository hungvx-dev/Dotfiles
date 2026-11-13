set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PAGER less
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

# zoxide
set -gx _ZO_DATA_DIR "$HOME/Dev/Dotfiles/zoxide"
set -gx _ZO_ECHO 1
set -gx _ZO_RESOLVE_SYMLINKS 1
set -eU _ZO_DATA_DIR _ZO_ECHO _ZO_RESOLVE_SYMLINKS

# lazygit, starship, ripgrep, tealdeer
set -gx LG_CONFIG_FILE "$HOME/.config/lazygit/config.yml"
set -gx STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"
set -gx RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/.ripgreprc"
