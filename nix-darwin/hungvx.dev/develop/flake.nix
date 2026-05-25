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
          # ensure fish shell (only once)
          if [ -z "$IN_NIX_SHELL_FISH" ]; then
            export IN_NIX_SHELL_FISH=1
            exec fish
          fi
        '';
      };

    in
    {
      devShells.${system} = {
        # =========================
        # 🧩 Project environment
        # =========================
        dev = mkShell (with pkgs; [
          mise
          rustup
        ]);

        # =========================
        # 🛠️ Tools environment
        # =========================
        tools = mkShell (with pkgs; [
          # CLI tools
          tree-sitter
        ]);
      };
    };
}
