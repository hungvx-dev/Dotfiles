{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
  ];
}
