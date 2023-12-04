#!/bin/sh
echo "---"

info() {
  printf "\r  [\033[00;34m..\033[0m] %s \n" "$1"
}

success() {
  printf "\r\033[2K [\033[00;32mOK\033[0m] %s \n" "$1"
  echo ''
}

link_config_file() {
  info "Run symlink"
  ./symlink.sh
  success "Linked"
}

install_xcode_command_line_tools() {
  info "Installing Xcode command line tools"
  xcode-select --install
  success "Installed Xcode command line tools"
}

install_homebrew() {
  info "Installing homebrew"
  ./bootstrap/macos/homebrew.sh
  success "Installed homebrew"
}

install_terminal() {
  info "Installing kitty"
  brew install --cask kitty
  success "Installed kitty"

  read -r -p "Do you want to install alacritty? [y|N] " response
  if [[ $response =~ (y|yes|Y) ]];then
    info "Installing alacritty"
    brew install --cask alacritty
    success "Installed alacritty!"
  fi
}

install_fish() {
  info "Installing fish"
  ./bootstrap/macos/fish.sh
  success "Installed fish"
}

install_setup_tmux() {
  info "Installing and setting tmux"
  ./bootstrap/macos/tmux.sh
  success "Installed and setted tmux"
}

install_tools() {
  info "Installing apps & tools"
  brew install --cask \
    karabiner-elements \
    openkey \
    cloudflare-warp \
    discord \
    figma \
    gitkraken \
    spotify \
    xmind \
    postman \
    microsoft-teams \
    telegram-desktop \
    google-chrome \
    visual-studio-code \
    1password-cli \
    notion \
    raycast \
    google-chrome \
    orbstack

  brew install vlc zoom obs

  brew install \
    fnm \
    git-delta \
    fzf \
    zoxide \
    lazygit \
    exercism \
    btop \
    tree \
    awscli
  success "Installed tools"
}

install_deps_tools() {
  info "Installing deps tools"
  brew install \
    fd \
    ripgrep \
    bat \
    gnu-sed \
    ncurses
  success "Installed deps tools"
}

install_fonts() {
  info "Installing tools"
  brew tap homebrew/cask-fonts
  brew install \
    font-jetbrains-mono \
    font-caskaydia-cove-nerd-font \
    font-fira-code-nerd-font \
    font-hack-nerd-font

  success "Installed fonts"
}

install_neovim() {
  info "Installing neovim"
  ./bootstrap/macos/neovim.sh
  success "Installed neovim"
}

install_window_management() {
  info "Installing WM"
  brew install \
    koekeishiya/formulae/yabai \
    koekeishiya/formulae/skhd
  success "Installed WM"
}

install_music() {
  info "Installing music"
  brew install cmus
  brew install cava
  brew install --cask background-music
  success "Installed music"
}

setup_mac_config() {
  # hide desktop icons
  killall Finder

  # reduce keyrepeat for faster typing in vim
  # defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
  # defaults write -g KeyRepeat -int 1         # normal minimum is 2 (30 ms)
  # defaults write -g ApplePressAndHoldEnabled -bool false
  ./bootstrap/macos/defaults.sh
}

link_config_file
install_xcode_command_line_tools
install_homebrew
install_terminal
install_fish
install_setup_tmux
install_tools
install_deps_tools
install_fonts
install_nvim
install_window_management
# install_music
setup_mac_config

echo "Finished installing! 🎉 🚀"
