{ config, pkgs, ... }:

{
  home.username = "hungvx.dev";
  home.homeDirectory = "/Users/hungvx.dev";
  home.file = {
    ".config/nvim".source = ~/Dev/Dotfiles/nvim;
    ".config/kitty".source = ~/Dev/Dotfiles/kitty;
    # ".config/fish".source = ~/Dev/Dotfiles/fish;
    ".config/starship".source = ~/Dev/Dotfiles/starship;
    ".config/tmux".source = ~/Dev/Dotfiles/tmux;
    ".config/lazygit".source = ~/Dev/Dotfiles/lazygit;
    ".config/bat".source = ~/Dev/Dotfiles/bat;
    # ".config/yabai".source = ~/Dev/Dotfiles/yabai;
    # ".config/skhd".source = ~/Dev/Dotfiles/skhd;
    # ".config/cmus".source = ~/Dev/Dotfiles/cmus;
    ".config/cava".source = ~/Dev/Dotfiles/cava;
    # ".config/ssh".source = ~/Dev/Dotfiles/ssh;
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
    # "$HOME/.nix-profile/bin"
  ];

  programs = {
    # git = {
    #   enable = true;
    #   delta = {
    #     enable = true;
    #   };
    # };
    # neovim = {
    #   enable = true;
    #   defaultEditor = true;
    # };
    # kitty = {
    #   enable = true;
    #   shellIntegration = {
    #     enableFishIntegration = true;
    #   };
    # };
    # ripgrep = {
    #   enable = true;
    # };
    # fd = {
    #   enable = true;
    # };
    # bat = {
    #   enable = true;
    # };
    # fzf = {
    #   enable = true;
    #   enableFishIntegration = true;
    #   tmux = {
    #     enableShellIntegration = true;
    #   };
    # };
    # eza = {
    #   enable = true;
    #   enableFishIntegration = true;
    #   icons = "always";
    # };
    # starship = {
    #   enable = true;
    #   enableFishIntegration = true;
    # };
    # tmux = {
    #   enable = true;
    #   keyMode = "vi";
    #   prefix = "C-a";
    #   shell = "\${pkgs.fish}/bin/fish";
    #   mouse = true;
    # };
    # zoxide = {
    #   enable = true;
    #   enableFishIntegration = true;
    # };
  };
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
