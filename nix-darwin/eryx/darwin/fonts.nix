{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    jetbrains-mono
    fira-code
    maple-mono.truetype
    nerd-fonts.symbols-only
  ];
}
