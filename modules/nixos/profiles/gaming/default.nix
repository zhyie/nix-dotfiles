{ pkgs, ... }:
{
  imports = [ ./options.nix ];

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
}
