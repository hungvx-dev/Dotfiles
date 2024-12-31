{ config, pkgs, ... }:

{
  home.username = "hungvx.dev";
  home.homeDirectory = "/Users/hungvx.dev";
  home.stateVersion = "24.11";
  home.file = {
    ".config/nvim".source = ~/Dev/Dotfiles/nvim;
    ".config/kitty".source = ~/Dev/Dotfiles/kitty;
    # ".config/fish".source = ~/Dev/Dotfiles/fish;
    ".config/starship".source = ~/Dev/Dotfiles/starship;
    ".config/tmux".source = ~/Dev/Dotfiles/tmux;
    ".config/lazygit".source = ~/Dev/Dotfiles/lazygit;
    ".config/bat".source = ~/Dev/Dotfiles/bat;
    ".config/yabai".source = ~/Dev/Dotfiles/yabai;
    ".config/skhd".source = ~/Dev/Dotfiles/skhd;
    ".config/cmus".source = ~/Dev/Dotfiles/cmus;
    ".config/cava".source = ~/Dev/Dotfiles/cava;
    ".config/ssh".source = ~/Dev/Dotfiles/ssh;
  };

  # programs = {
  #   kitty = { enable = true; };
  # };
  programs.home-manager.enable = true;
}
