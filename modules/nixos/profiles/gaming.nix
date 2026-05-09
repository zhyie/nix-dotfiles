{ pkgs, nixos, ... }:
{
  imports = [ nixos.programs.games ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs = {
    gamemode = {
      enable = true;
      settings = {
        general = {
          igpu_desiredgov = "performance";
        };

        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'Gamemode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'Gamemode ended'";
        };
      };
    };

    gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
}
