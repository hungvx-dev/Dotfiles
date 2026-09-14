{
  description = "Dev environments (project + tools)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      mkShell = packages: pkgs.mkShell {
        inherit packages;

        shellHook = ''
          if [ -z "$IN_NIX_SHELL_FISH" ]; then
            export IN_NIX_SHELL_FISH=1
            exec fish
          fi
        '';
      };

    in
    {
      devShells.${system} = {
        dev = mkShell (with pkgs; [
          mise
        ]);

        tools = mkShell (with pkgs; [
          tree-sitter
        ]);
      };
    };
}
