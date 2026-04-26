{ pkgs, ... }:
{
  environment.systemPackages = builtins.attrValues {
    # Nano editor is installed by default.
    inherit (pkgs)
      wget
      unzip
      xclip
      ;
  };

  # Enable gtk settings
  programs.dconf.enable = true;

  # # suckless software
  # suckless = {
  #   dwm = true;
  #   dmenu = true;
  #   slstatus = true;
  #   st = true;
  # };

  services.xserver = {
    serverFlagsSection = ''
      Option "BlankTime" "0"
      Option "StandbyTime" "10"
      Option "SuspendTime" "20"
      Option "OffTime" "30"
    '';
  };

  modules.nixos = {
    # profiles = {
    #   graphical = [ "xserver" ];
    # };

    gaming = {
      games = [
        "steam"
        "proton"
        "bottles"
        "roblox"
        "mcpe"
      ];
    };

    backlight = {
      min = 5;
      upKey = 233;
      downKey = 232;
    };
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
