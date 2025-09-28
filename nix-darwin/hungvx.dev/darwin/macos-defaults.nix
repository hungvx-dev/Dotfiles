{ self, username, ... }:
{
  system = {
    primaryUser = username;
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 5;

    defaults = {
      NSGlobalDomain = {
        AppleICUForce24HourTime = true;
        ApplePressAndHoldEnabled = false;
        KeyRepeat = 1;
        InitialKeyRepeat = 10;
        "com.apple.swipescrolldirection" = false;
      };
      finder = {
        ShowPathbar = true;
        ShowStatusBar = true;
        QuitMenuItem = true;
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "clmv";
      };
      dock = {
        tilesize = 17;
        magnification = true;
        largesize = 128;
        orientation = "right";
        show-recents = false;
        mru-spaces = false;
      };
      controlcenter = {
        AirDrop = false;
        BatteryShowPercentage = true;
        Bluetooth = true;
        Display = true;
        Sound = true;
      };
    };
  };
}
