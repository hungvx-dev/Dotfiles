{
  description = "Dev for frontend and backend";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
            pkgs.volta
            pkgs.bun
          ];
          shellHook = ''
            export SHELL=$(which fish)
               if [ -z "$IN_NIX_SHELL_FISH" ]; then
                 export IN_NIX_SHELL_FISH=1
                 exec $SHELL
               fi
            echo "🚀 Frontend environment loaded (Node + Bun)"
          '';
        };

        be = pkgs.mkShell {
          buildInputs = [
            pkgs.rustup
            pkgs.go
          ];
          shellHook = ''
            export SHELL=$(which fish)
               if [ -z "$IN_NIX_SHELL_FISH" ]; then
                 export IN_NIX_SHELL_FISH=1
                 exec $SHELL
               fi
            echo "🔧 Backend environment loaded (Rust + Go)"
          '';
        };
      };
    };
}
