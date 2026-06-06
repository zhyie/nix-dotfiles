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

  modules = {
    #: Backlight
    backlight.keycodes = {
      increase = 233;
      decrease = 232;
    };

    laptop.enable = true;
    gaming.enable = true;

    graphical = {
      wayland.niri = true;
      display.manager = "ly";
    };
  };

  # suckless = {
  #   dwm = {
  #     enable = true;
  #     package = pkgs.dwm;
  #   };
  #   dmenu = {
  #     enable = true;
  #     package = pkgs.dmenu;
  #   };
  #   st = {
  #     enable = true;
  #     package = pkgs.st;
  #   };
  #   slstatus = {
  #     enable = true;
  #     package = pkgs.slstatus;
  #   };
  # };

  services.xserver = {
    serverFlagsSection = ''
      Option "BlankTime" "0"
      Option "StandbyTime" "10"
      Option "SuspendTime" "20"
      Option "OffTime" "30"
    '';
  };

  #: Prevents overheating on Intel CPUs
  services.tlp = {
    enable = true;
    settings = {
      #: Performance scaling
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 60;

      # Laptop runs hot when on power but not on battery
      # This tells tlp to always run in battery mode
      TLP_DEFAULT_MODE = "BAT";
      TLP_PERSISTENT_DEFAULT = 1;
    };
  };

  time.timeZone = "Asia/Manila";
  i18n.extraLocales = [ "tl_PH.UTF-8/UTF-8" ];
  console = {
    font = "ter-v20n";
    packages = [ pkgs.terminus_font ];
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
