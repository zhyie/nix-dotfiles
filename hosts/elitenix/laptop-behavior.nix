{ config, lib, pkgs, ... }:

{
  # Enable screensaver
  services.xscreensaver.enable = true;

  # Laptop power key and lid behavior
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

    # IdleAction = "suspend";
    # IdleActionSec = "30m";
  };

  # Power management
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  # performance scaling
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 60;

      # Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80;  # 80 and above it stops charging

      # Laptop runs hot when on power but not on battery
      # This tells tlp to always run in battery mode
      TLP_DEFAULT_MODE = "BAT";
      TLP_PERSISTENT_DEFAULT = 1;
    };
  };

}
