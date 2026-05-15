{ ... }:
{
  # Laptop power key and lid handler
  services.logind.settings.Login = {
    # Suspend when lid is closed
    HandleLidSwitch = "suspend";
    # Suspend when lid is closed and connected to power
    HandleLidSwitchExternalPower = "suspend";
    # Nothing happens when another screen is connected
    HandleLidSwitchDocked = "ignore";

    # Suspend when power key is pressed
    HandlePowerKey = "suspend";
    # Power off when power key is pressed longer
    HandlePowerKeyLongPress = "poweroff";

    IdleAction = "suspend";
    IdleActionSec = "30m";
  };
}
