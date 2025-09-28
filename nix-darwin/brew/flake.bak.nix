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
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
  };

  outputs = { self, nix-darwin, nix-homebrew, ... }:
    let
      username = "hungvx.dev";
      home = "/Users/${username}";
      configuration = { pkgs, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        nix.settings.experimental-features = [ "nix-command" "flakes" ];
        nixpkgs.config.allowUnfree = true;
        nixpkgs.hostPlatform = "aarch64-darwin";

        environment.systemPackages = with pkgs; [
          neovim
          kitty
          # ghostty
          tmux
          starship

          # fzf
          skim
          ripgrep
          fd
          bat

          zoxide
          eza
          dust
          duf
          tealdeer
          navi
          yazi
          btop

          git
          delta
          lazygit

          stow

          cmus
          cava

          monitorcontrol
          # raycast
          discord
          google-chrome
          zoom-us
          # obsidian
          # telegram-desktop
          docker
          colima
          lazydocker
          rainfrog
          nodejs

          ollama
        ];

        programs.fish.enable = true;
        users.users.${username} = {
          name = username;
          home = home;
          shell = pkgs.fish;
        };


        homebrew = {
          enable = true;
          taps = [
            "koekeishiya/formulae"
            "jackielii/tap"
          ];
          brews = [
            # "git-graph"
            "yabai"
            "skhd-zig"
          ];
          casks = [
            "openkey"
            "figma"
            "pearcleaner"
            "brave-browser"
            "zen"
            "karabiner-elements"
            "vlc"
            "blackhole-2ch"
            # "raycast"
            # "zen-browser"
            # "clop"
            # "notion"
            # "stremio"
            # "xmind"
          ];
          # greedyCasks = true;
          onActivation = {
            cleanup = "zap";
            # cleanup = "uninstall";
            autoUpdate = true;
            upgrade = true;
          };
        };

        fonts.packages = with pkgs; [
          jetbrains-mono
          nerd-fonts.iosevka
          nerd-fonts.jetbrains-mono
        ];

        # services.yabai.enable = true;
        # services.skhd.enable = true;

        system = {
          primaryUser = username;
          configurationRevision = self.rev or self.dirtyRev or null;
          stateVersion = 5;
          defaults = {
            NSGlobalDomain = {
              AppleICUForce24HourTime = true;
              ApplePressAndHoldEnabled = false;
              KeyRepeat = 1;
              InitialKeyRepeat = 10;
              "com.apple.swipescrolldirection" = false;
            };
            finder = {
              ShowPathbar = true;
              ShowStatusBar = true;
              QuitMenuItem = true;
              AppleShowAllExtensions = true;
              FXPreferredViewStyle = "clmv";
            };
            dock = {
              tilesize = 17;
              magnification = true;
              largesize = 128;
              orientation = "right";
              show-recents = false;
              mru-spaces = false;
            };
            controlcenter = {
              AirDrop = false;
              BatteryShowPercentage = true;
              Bluetooth = true;
              Display = true;
              Sound = true;
            };
            # universalaccess = {
            #   reduceMotion = true;
            # };
          };
        };
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#FeiYu
      darwinConfigurations."FeiYu" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = username;
              autoMigrate = true;
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."FeiYu".pkgs;
    };
}

