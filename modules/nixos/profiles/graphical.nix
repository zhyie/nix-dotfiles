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
    nixos.sessions.display-managers.default
    nixos.sessions.display-managers.lightdm
    nixos.sessions.display-managers.lemurs
    nixos.sessions.display-managers.ly
    nixos.sessions.xserver.default
    nixos.sessions.xserver.screensaverlock
    nixos.sessions.wayland.default
    nixos.sessions.wayland.niri
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
        xdg.portal = {
          enable = lib.mkDefault true;

          config.niri = {
            default = [ "gtk" ];
          };

          # Recommended by upstream, required for screencast support
          # https://github.com/YaLTeR/niri/wiki/Important-Software#portals
          # extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
          extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        };

        environment.systemPackages =
          lib.optionals (xserver.enable || wayland.enable) [
            pkgs.libnotify
          ]
          ++ lib.optionals xserver.enable [ pkgs.xclip ]
          ++ lib.optionals wayland.enable [ pkgs.wl-clipboard ];
      }
    ];
}
