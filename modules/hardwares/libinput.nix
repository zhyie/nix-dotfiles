{ pkgs, ... }:

{
  # Enable input devices support.
  services.libinput = {
    enable = true;

    # Touchpad Settings
    touchpad = {
      accelProfile = "adaptive";
      accelSpeed = "0.2";

      tapping = true;
      tappingDragLock = true;
      tappingButtonMap = "lmr";

      middleEmulation = true;

      scrollMethod = "twofinger";
      horizontalScrolling = true;
      naturalScrolling = true;

      # Additional options for touchpad.
      #additionalOptions = '' Options "" "" '';
    };

    # Mouse Settings
    mouse = {
      accelProfile = "adaptive";
      accelSpeed = "0.0";

      #tapping = true;
      tappingDragLock = false;

      middleEmulation = false;

      horizontalScrolling = true;
      naturalScrolling = true;

      # Additional options for mouse.
      #additionalOptions = '' Options "" "" '';
    };
  };

  # Enable configuration for trackpoints.
  hardware.trackpoint = {
    enable = true;
    press_to_select = true;
    emulateWheel = true;
  };
}
