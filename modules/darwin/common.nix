# Note search mynixos.com
# $darwin-help
{ pkgs, ... }:
{
  security.pam.services.sudo_local.touchIdAuth = true;
  system = {
    stateVersion = 4;

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        AppleInterfaceStyle = "Dark";

        KeyRepeat = 2; # 120, 90, 60, 30, 12, 6, 2
        InitialKeyRepeat = 15; # 120, 94, 68, 35, 25, 15
        "com.apple.keyboard.fnState" = true; # Make F1, F2, etc. keys behave as standard function keys
        NSAutomaticCapitalizationEnabled = false;

        ApplePressAndHoldEnabled = false;
        "com.apple.mouse.tapBehavior" = 1;

        "com.apple.trackpad.forceClick" = false; # Disables Force Click
        "com.apple.trackpad.scaling" = 1.0; # Configures the trackpad tracking speed (0 to 3). The default is “1”.AppleShowAllFiles = true;

        "com.apple.sound.beep.volume" = 0.0; # Mute the system beep
        "com.apple.sound.beep.feedback" = 0; # Mute the feedback sound
      };

      #
      # Skoða hvort ég hafi leyfi til að gera þetta
      #
      # universalaccess = {
      #   closeViewScrollWheelToggle = true; # Use Scroll Wheel to Zoom
      #   closeViewZoomFollowsFocus = true; # Follow the keyboard focus while zoomed in
      #   mouseDriverCursorSize = 1.0; # Default is 1.0
      # };

      ".GlobalPreferences" = {
        "com.apple.mouse.scaling" = 1.8; # Configures the mouse tracking speed (0 to 3). The default is “1.5”.
      };

      # Configure Fn key to do nothing when pressed
      hitoolbox.AppleFnUsageType = "Do Nothing";

      dock = {
        autohide = true;
        show-recents = false;
        tilesize = 20;
        orientation = "left";
      };

      finder = {
        AppleShowAllFiles = true;
        FXPreferredViewStyle = "clmv";
        _FXShowPosixPathInTitle = false;
        FXDefaultSearchScope = "SCcf";
        FXRemoveOldTrashItems = true;
        ShowPathbar = true;
      };

      screencapture = {
        location = "~/Downloads/";
        type = "png";
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
        TrackpadThreeFingerTapGesture = 0; # Disables the three-finger tap for dictionary lookup
      };

      magicmouse = {
        MouseButtonMode = "TwoButton";
      };
    };

    keyboard = {
      enableKeyMapping = true;
    };

    activationScripts.postActivation.text = ''
      # normal minimum is 15 (225 ms)\ defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
      defaults write -g InitialKeyRepeat -int 10 
      defaults write -g KeyRepeat -int 1
    '';
  };
}
