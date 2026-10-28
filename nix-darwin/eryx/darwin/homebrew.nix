{ ... }:
{
  homebrew = {
    enable = true;
    taps = [ "cloaky233/tap" ];
    brews = [
      "siltop"
    ];
    casks = [
      "openkey"
      "figma"
      "pearcleaner"
      "brave-browser"
      "karabiner-elements"
      # "vlc"
      # "blackhole-2ch"
      "yaak"
      # "discord"
      # "zoom"
      "monitorcontrol"
      # "betterdisplay"
      # "obsidian"
      # "claude-code"
    ];
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}

