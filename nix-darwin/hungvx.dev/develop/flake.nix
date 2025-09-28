{
  description = "Dev for frontend and backend";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin"; # máy M1/M2
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system} = {
        fe = pkgs.mkShell {
          buildInputs = [
            pkgs.nodejs
            pkgs.bun
          ];
          shellHook = ''
            echo "🚀 Frontend environment loaded (Node + Bun)"
          '';
        };

        be = pkgs.mkShell {
          buildInputs = [
            pkgs.rustup
            pkgs.go
          ];
          shellHook = ''
            echo "🔧 Backend environment loaded (Rust + Go)"
          '';
        };
      };
    };
}
