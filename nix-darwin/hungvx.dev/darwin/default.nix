{ ... }:
{
  imports = [
    ./system-packages.nix
    ./homebrew.nix
    ./users.nix
    ./fonts.nix
    ./macos-defaults.nix
  ];
}
