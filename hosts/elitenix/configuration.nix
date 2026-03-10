{ pkgs, nixos, ... }:

{
  imports = [
    nixos.core
    nixos.hardware
    nixos.services
  ];

  time.timeZone = "Asia/Manila";
  i18n.defaultLocale = "en_US.UTF-8";

  # suckless software
  suckless = {
    dwm = true;
    dmenu = true;
    slstatus = true;
    st = true;
  };

  # intel -- said to remove screen tearing
  # services.xserver.videoDrivers = [ "intel" ];
  # services.xserver.deviceSection = ''
  #   Option "DRI" "2"
  #   Option "TearFree" "true"
  # '';

  # hardware-related
  boot.kernelParams = [ "i915.enable_guc=2" ];
  hardware.intelgpu.vaapiDriver = "intel-media-driver";

  # Console settings.
  console = {
    font = "sun12x22";
    keyMap = "us";
  };

  #######################################
  #   OFF LIMIT  SYSTEM STATE VERSION   #
  #######################################
  # Do NOT change, unless all the changes it would make to a configuration
  # have been manually inspected and the data is migrated accordingly.
  # For more information, see `man configuration.nix` or
  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion.
  system.stateVersion = "25.11";
  # Help is available in the configuration.nix(5) man page, on
  # https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
}
