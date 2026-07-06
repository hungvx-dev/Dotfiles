{ pkgs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowBroken = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  environment.systemPackages = with pkgs; [
    # git
    git delta lazygit stow
    # git-graph

    # shell utils
    neovim kitty tmux starship
    # ghostty
    zoxide eza btop htop
    # navi yazi dust duf tealdeer

    # search
    skim ripgrep fd bat

    # media
    # cmus cava

    # tools
    lazydocker rainfrog
    # dev
    docker colima lima
  ];

  programs.fish.enable = true;
}
