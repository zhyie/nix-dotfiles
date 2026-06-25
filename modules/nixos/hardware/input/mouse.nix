{ ... }:
{
  # Enable input devices support.
  services.libinput = {
    # Mouse Settings
    mouse = {
      accelProfile = "adaptive";
      accelSpeed = "0.0";

      # tapping = true;
      tappingDragLock = false;
      middleEmulation = false;
      horizontalScrolling = true;
      naturalScrolling = false;
    };
  };
}
