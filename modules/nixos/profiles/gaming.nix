{
  config,
  lib,
  pkgs,
  nixos,
  ...
}:
{
  imports = [ nixos.services.flatpak ];

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

  environment.systemPackages =
    #: Intall enabled games
    lib.concatMap (game: lib.optionals (game.enable && game.version == "nixpkgs") game.packages) (
      lib.attrValues config.modules.gaming.games
    )
    #: Overlay for monitoring FPS, hardware loads, and more
    ++ [ pkgs.mangohud ];
}
