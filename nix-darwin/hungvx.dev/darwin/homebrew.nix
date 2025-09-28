{ ... }:
{
  homebrew = {
    enable = true;
    taps = [ "koekeishiya/formulae" "jackielii/tap" "theboredteam/boring-notch" ];
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
      "boring-notch"
    ];
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}

