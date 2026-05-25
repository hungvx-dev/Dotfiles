{ ... }:
{
  homebrew = {
    enable = true;
    taps = [ "koekeishiya/formulae" "jackielii/tap" "theboredteam/boring-notch" ];
    brews = [ "yabai" "git-graph" "cava" "opencode" ];
    casks = [
      "openkey"
      "figma"
      "pearcleaner"
      "brave-browser"
      "karabiner-elements"
      "vlc"
      "blackhole-2ch"
      "yaak"
      "discord"
      "zoom"
      "betterdisplay"
      "obsidian"
      "claude-code"
    ];
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = false;
    };
  };
}

