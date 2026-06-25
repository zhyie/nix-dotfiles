{
  config,
  lib,
  nixos,
  ...
}:
{
  imports = [
    nixos.hardware.brightnessctl
    nixos.hardware.bluetooth
    nixos.hardware.pipewire
    nixos.hardware.touchpad
    nixos.hardware.mouse
    nixos.services.avahi
  ];

  modules.laptop.enable = true;

  services = {
    pipewire.enable = true;
    bluetooth.enable = true;
    avahi.enable = true;

    #: POWER KEY AND LID HANDLER
    logind.settings.Login = lib.mkIf config.modules.laptop.enable {
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

    #: D-BUS FOR POWER MANAGEMENT
    upower = {
      enable = true;
      #: Policy for warnings and action based on battery levels
      usePercentageForPolicy = true;
      percentageLow = 20;
      percentageCritical = 10;
      percentageAction = 5;
      allowRiskyCriticalPowerAction = true;
      criticalPowerAction = "Hibernate";
    };
  };

  #: POWER MANAGEMENT
  powerManagement = {
    enable = true;
    # Auto tuning on startup
    powertop.enable = true;
  };
}
