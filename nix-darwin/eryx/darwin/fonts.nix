{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.symbols-only
  ];
}
