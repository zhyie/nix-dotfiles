{ pkgs, ... }:

{
  # Enable bluetooth support.
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
    powerOnBoot = false; # Power up the Bluetooth controller on boot.

    input = {
      General = {
        IdleTimeout = 120;        # Set idle timeout (in seconds) before disconnecting input device.
        # UserspaceHID = true;      # Enable HID protocol handling in userspace input profile.
        # ClassicBondedOnly = true; # Limit HID connections to bonded devices.
        # LEAutoSecurity = true;    # Enables upgrades of security automatically if required.
      };
    };
    # network = { General.DisableSecurity = true }; # Disable link encryption: default=false

    # List of options for bluez: https://github.com/bluez/bluez/blob/master/src/main.conf
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Name = "BlueZ";
        ControllerMode = "dual";
        FastConnectable = true;
        Experimental = true;
      };
    };
  };

  # Graphical interface for managing bluetooth
  services.blueman.enable = true;
}
