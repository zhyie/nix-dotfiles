{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config.modules.graphical.wayland) niri;
in
{
  environment.systemPackages = lib.optionals niri [
    pkgs.niri
    pkgs.xwayland-satellite
    pkgs.noctalia-shell
  ];

  services = lib.optionalAttrs niri {
    displayManager.sessionPackages = [ pkgs.niri ];

    # graphical-desktop.enable = true;
    xserver.desktopManager.runXdgAutostartIfNone = lib.mkDefault true;

    # Recommended by upstream
    # https://github.com/YaLTeR/niri/wiki/Important-Software#portals
    # gnome.gnome-keyring.enable = lib.mkDefault true;
  };

  systemd = lib.optionalAttrs niri {
    packages = [ pkgs.niri ];

    user.services.niri = {
      restartIfChanged = false;
      enableDefaultPath = false;
    };
  };

  xdg.portal = lib.optionalAttrs niri {
    config.niri = {
      default = [ "gtk" ];
    };

    # Recommended by upstream, required for screencast support
    # https://github.com/YaLTeR/niri/wiki/Important-Software#portals
    # extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };
}
