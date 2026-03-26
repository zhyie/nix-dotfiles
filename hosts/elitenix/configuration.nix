{ pkgs, ... }:
{
  # Enable backlight.
  programs.light.enable = true;
  # Enable gtk settings
  programs.dconf.enable = true;

  environment.systemPackages = builtins.attrValues {
    # Nano editor is installed by default.
    inherit (pkgs)
      wget
      unzip
      ;
  };

  # suckless software
  suckless = {
    dwm = true;
    dmenu = true;
    slstatus = true;
    st = true;
  };

  time.timeZone = "Asia/Manila";
  i18n.defaultLocale = "en_US.UTF-8";
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
