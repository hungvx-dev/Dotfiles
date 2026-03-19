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
        dev = pkgs.mkShell {
          buildInputs = [
            pkgs.mise
            pkgs.rustup
          ];
          shellHook = ''
            export SHELL=$(which fish)
               if [ -z "$IN_NIX_SHELL_FISH" ]; then
                 export IN_NIX_SHELL_FISH=1
                 exec $SHELL
               fi
          '';
        };
      };
    };
}
