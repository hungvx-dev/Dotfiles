{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.symbols-only
    # nerd-fonts.jetbrains-mono
    # nerd-fonts.iosevka
  ];
}
