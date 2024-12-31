{
  description = "FeiYu nix-darwin system flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
    let
      configuration = { pkgs, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        nix.settings.experimental-features = "nix-command flakes";
        nixpkgs = {
          config = { allowUnfree = true; };
          hostPlatform = "aarch64-darwin";
        };
        environment.systemPackages = [
          pkgs.neovim
          pkgs.kitty
          # pkgs.zellij
          pkgs.nushell
          pkgs.starship
          pkgs.eza
          pkgs.fzf
          pkgs.ripgrep
          pkgs.fd
          pkgs.bat
          pkgs.btop
          pkgs.delta
          pkgs.lazygit
          pkgs.zoxide
          pkgs.fnm
          pkgs.cmus
          pkgs.cava
          pkgs.raycast
          pkgs.brave
          pkgs.discord
          pkgs.google-chrome
          # pkgs.xmind
          pkgs.zoom-us
        ];

        homebrew = {
          enable = true;
          casks = [
            "openkey"
            "figma"
            "pearcleaner"
            "karabiner-elements"
            "vlc"
            "xmind"
            "ghostty"
          ];
          onActivation.cleanup = "zap";
        };

        fonts.packages = [
          pkgs.jetbrains-mono
          pkgs.nerd-fonts.jetbrains-mono
        ];

        services = {
          nix-daemon = { enable = true; };
          yabai = { enable = true; };
          skhd = { enable = true; };
          # karabiner-elements = { enable = true; };
        };

        programs = {
          # kitty = { enable = true; };
          fish = { enable = true; };
          tmux = { enable = true; };
        };

        system.configurationRevision = self.rev or self.dirtyRev or null;
        system.stateVersion = 5;
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#FeiYu
      darwinConfigurations."FeiYu-DPHV" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "hungvx.dev";
              autoMigrate = true;
            };
          }
          home-manager.darwinModules.home-manager
          {
            users.users."feiyu".home = "/Users/feiyu";
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users."feiyu" = import ./home.nix;
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."FeiYu-DPHV".pkgs;
    };
}
