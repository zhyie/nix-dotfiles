{ pkgs, ... }:

{
  #-------------------------------------------------
  # Package repository and configuration options:
  # https://github.com/Gerschtli/dwm-status
  #-------------------------------------------------
  # Nixpkgs package:
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/dw/dwm-status/package.nix
  #-------------------------------------------------
  # Nixpkgs module:
  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/misc/dwm-status.nix
  #-------------------------------------------------
  # Home Manager module
  # https://github.com/nix-community/home-manager/blob/master/modules/services/dwm-status.nix
  #-------------------------------------------------

  environment.systemPackages = with pkgs; [
    dwm-status
    # The following are dependencies:
    alsa-utils
    dig
    wirelesstools
  ];

  # Configure in nix-way or
  # import toml file for nixos module or
  # import json file for home manager module
  services.dwm-status = {
    enable = true;
    #settings = builtins.fromTOML (builtins.readFile ./toml-status.toml);
    settings = {
      separator = " | ";
      order = [ "backlight" "audio" "battery" "time" ];
      backlight = {
        device = "intel_backlight";
        template = "BL {BL}%";
      };
      audio = {
        control = "Master";
        template = "VOL {VOL}%";
      };
      battery = {
        enable_notifier = true;
        notifier_levels = [ 5 8 10 15 20 ];
        notifier_critical = 10;
        icons = [ "BAT" ];
      };
      time = {
        format = "%a %b %d %H:%M%";
        update_seconds = false;
      };
    };
  };
}
