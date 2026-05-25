{ nixos, ... }:
{
  imports = [
    nixos.hardware.pipewire
    nixos.hardware.touchpad
    nixos.hardware.mouse
    nixos.hardware.power
    nixos.hardware.light
    nixos.hardware.bluetooth
  ];

  #: Laptop power key and lid handler
  services.logind.settings.Login = {
    #: Suspend when lid is closed
    HandleLidSwitch = "suspend";
    #: Suspend when lid is closed and connected to power
    HandleLidSwitchExternalPower = "suspend";
    #: Nothing happens when another screen is connected
    HandleLidSwitchDocked = "ignore";

    #: Suspend when power key is pressed
    HandlePowerKey = "suspend";
    #: Power off when power key is pressed longer
    HandlePowerKeyLongPress = "poweroff";

    #: Suspend when idle for 30 minutes
    IdleAction = "suspend";
    IdleActionSec = "30m";
  };

  modules.laptop.enable = true;
}
