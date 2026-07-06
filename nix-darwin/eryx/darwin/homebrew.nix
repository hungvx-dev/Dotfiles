{ ... }:
{
  homebrew = {
    enable = true;
    taps = [];
    # brews = [ "git-graph" "opencode" ];
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

