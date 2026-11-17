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

      mkShell = name: packages: pkgs.mkShell {
        inherit packages;

        shellHook = ''
          if [ -z "$IN_NIX_SHELL_FISH" ]; then
            export IN_NIX_SHELL_FISH=1
            export NIX_DEV_SHELL_NAME="${name}"
            exec fish
          fi
        '';
      };

    in
    {
      devShells.${system} = {
        dev = mkShell "dev" (with pkgs; [
          mise
        ]);

        tools = mkShell "tools" (with pkgs; [
          tree-sitter
          yt-dlp
        ]);
      };
    };
}
