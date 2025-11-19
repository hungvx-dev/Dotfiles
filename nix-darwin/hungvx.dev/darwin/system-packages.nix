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
    zoxide eza dust duf tealdeer navi yazi btop

    # search
    skim ripgrep fd bat

    # media
    cmus

    # desktop apps
    monitorcontrol discord google-chrome zoom-us

    # dev tools
    docker colima lazydocker rainfrog
    # ollama
  ];

  programs.fish.enable = true;
}

