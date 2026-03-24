{ ... }:
{
  # Enable input devices support.
  services.libinput = {
    enable = true;

    # Touchpad Settings
    touchpad = {
      accelProfile = "adaptive";
      accelSpeed = "0.3";

      tapping = true;
      tappingDragLock = false;
      tappingButtonMap = "lrm";

      middleEmulation = true;
      scrollMethod = "twofinger";
      horizontalScrolling = true;
      naturalScrolling = false;
    };

    # Mouse Settings
    mouse = {
      accelProfile = "adaptive";
      accelSpeed = "0.0";

      # tapping = true;
      tappingDragLock = false;
      middleEmulation = false;
      horizontalScrolling = true;
      naturalScrolling = true;
    };
  };

  # Enable configuration for trackpoints.
  hardware.trackpoint = {
    enable = true;
    press_to_select = true;
    emulateWheel = true;
  };
}
