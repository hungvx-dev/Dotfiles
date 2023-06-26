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
  # ./symlink.sh
  success "Linked"
}

# Intall Xcode command line tools
install_xcode_command_line_tools() {
  info "Installing Xcode command line tools"
  # xcode-select --install
  success "Installed Xcode command line tools"
}

install_homebrew() {
  info "Installing homebrew"
  ./homebrew.sh
  success "Installed homebrew"
}

install_terminal() {
  info "Installing kitty"
  # brew install --cask kitty
  success "Installed kitty"
}

install_fish() {
  info "Installing fish"
  ./fish.sh
  success "Installed fish"
}

install_setup_tmux() {
  info "Installing and setting tmux"
  ./tmux.sh
  success "Installed and setted tmux"
}

install_tools() {
  info "Installing tools"
  # brew install --cask \
  #   postman \
  #   google-chrome \
  #   visual-studio-code \
  #   notion \
  #   raycast

  # brew install \
  #   pnpm \
  #   fzf \
  #   autojump \
  #   lazygit \
  #   exercism \
  #   ruby \
  #   awscli \
  #   wireguard-tools \
  #   orbstack
  success "Installed tools"
}

install_deps_tools() {
  info "Installing deps tools"
  # brew install \
  #   fd \
  #   ripgrep \
  #   bat \
  #   gnu-sed \
  #   ncurses
  success "Installed deps tools"
}

install_neovim() {
  info "Installing neovim"
  ./neovim.sh
  success "Installed neovim"
}

install_window_management() {
  info "Installing WM"
  # brew install \
  #   koekeishiya/formulae/yabai \
  #   koekeishiya/formulae/skhd
  success "Installed WM"
}

install_music() {
  info "Installing music"
  # brew install cmus
  # brew install cava
  # brew install --cask background-music
  success "Installed music"
}

link_config_file
install_xcode_command_line_tools
install_homebrew
install_terminal
install_fish
install_setup_tmux
install_tools
install_neovim
install_deps_tools
install_neovim
install_window_management
install_music

echo "Finished installing! 🎉 🚀"
