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
  };
}
