{
  description = "FeiYu nix-darwin system flake";

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
      username = "hungvx.dev";
      home = "/Users/${username}";
    in
    {
      darwinConfigurations."FeiYu" = nix-darwin.lib.darwinSystem {
        modules = [
          (import ./darwin)
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

      darwinPackages = self.darwinConfigurations."FeiYu".pkgs;
    };
}

