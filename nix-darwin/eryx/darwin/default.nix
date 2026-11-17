{ ... }:
{
  imports = [
    ./dev-shells.nix
    ./macos-defaults.nix
    ./fonts.nix
    ./system-packages.nix
    ./homebrew.nix
    ./users.nix
  ];
}
