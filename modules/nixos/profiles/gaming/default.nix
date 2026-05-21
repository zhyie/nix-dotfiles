{
  config,
  lib,
  pkgs,
  nixos,
  hostConfig,
  ...
}:
{
  imports = [
    ./options.nix
    nixos.services.flatpak
  ];

  #: Hardware accelerated graphics drivers
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs = {
    #: Optimization of Linux gaming
    gamemode = {
      enable = true;
      settings = {
        general.igpu_desiredgov = "performance";
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'Gamemode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'Gamemode ended'";
        };
      };
    };

    #: Session micro-compositor
    gamescope = {
      enable = true;
      capSysNice = true;
    };
  };

  #: Overlay for monitoring FPS, hardware loads, and more
  environment.systemPackages = [ pkgs.mangohud ];

  modules.flatpak.enable =
    let
      inherit (lib) genAttrs attrValues any;
      inherit (hostConfig) userList;
      userAttrs = genAttrs userList (u: config.home-manager.users.${u}.modules.flatpak.enable);
      flatpak = attrValues userAttrs;
    in
    any (c: c == true) flatpak;
}
