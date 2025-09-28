{
  description = "Eryx Ryan nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = { self, nix-darwin, nix-homebrew, ... }:
    let
      host = "FeiYu";
      username = "hungvx.dev";
      home = "/Users/${username}";
    in
    {
      darwinConfigurations.${host} = nix-darwin.lib.darwinSystem {
        modules = [
          (import ./darwin) # include macos-system packages homebrew users fonts
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
        specialArgs = { inherit username home self; };
      };

      darwinPackages = self.darwinConfigurations.${host}.pkgs;
    };
}

