{ ... }:
{
  homebrew = {
    enable = true;
    taps = [ "koekeishiya/formulae" "jackielii/tap" "theboredteam/boring-notch" ];
    brews = [ "yabai" "git-graph" "cava" ];
    casks = [
      "openkey"
      "figma"
      "pearcleaner"
      "brave-browser"
      "zen"
      "karabiner-elements"
      "vlc"
      "blackhole-2ch"
      "yaak"
    ];
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}

