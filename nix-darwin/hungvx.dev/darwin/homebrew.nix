{ ... }:
{
  homebrew = {
    enable = true;
    taps = [ "koekeishiya/formulae" "jackielii/tap" ];
    brews = [ "yabai" "skhd-zig" ];
    casks = [
      "openkey"
      "figma"
      "pearcleaner"
      "brave-browser"
      "zen"
      "karabiner-elements"
      "vlc"
      "blackhole-2ch"
    ];
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}

