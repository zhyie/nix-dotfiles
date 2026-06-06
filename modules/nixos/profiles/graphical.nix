{
  config,
  lib,
  pkgs,
  nixos,
  ...
}:
{
  imports = [
    nixos.services.flatpak
    nixos.display-managers.default
    nixos.display-managers.lightdm
    nixos.display-managers.lemurs
    nixos.display-managers.ly
    nixos.xserver.default
    nixos.xserver.screensaverlock
    nixos.wayland.default
    nixos.wayland.niri
  ];

  options.modules.graphical = {
    xserver = {
      dwm = lib.mkEnableOption "Enable dwm.";
    };

    wayland = {
      niri = lib.mkEnableOption "Enable niri.";
    };

    display = {
      manager = lib.mkOption {
        type = lib.types.nullOr (
          lib.types.enum [
            "lightdm"
            "lemurs"
            "ly"
          ]
        );
        default = null;
        description = "Display manager to use.";
      };
    };
  };

  /**
    IMPLEMENTATION
  */
  config =
    let
      inherit (config.modules) graphical xserver wayland;
      isEnable = attr: lib.any (c: c) (lib.attrValues attr);
    in
    lib.mkMerge [
      {
        #: Enable global options.
        modules.xserver.enable = isEnable graphical.xserver;
        modules.wayland.enable = isEnable graphical.wayland;

        programs.dconf.enable = lib.mkDefault true;
        environment.systemPackages =
          lib.optionals (xserver.enable || wayland.enable) [
            pkgs.libnotify
          ]
          ++ lib.optionals xserver.enable [ pkgs.xclip ]
          ++ lib.optionals wayland.enable [ pkgs.wl-clipboard ];
      }
    ];
}
