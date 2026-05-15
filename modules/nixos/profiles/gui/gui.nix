{
  config,
  lib,
  pkgs,
  nixos,
  hostConfig,
  ...
}:
let
  inherit (lib)
    mkDefault
    mkEnableOption
    mkOption
    types
    mkMerge
    mkIf
    elem
    elemAt
    ;
  inherit (types) listOf str enum;
  cfg = config.modules.gui;

  manager = [
    "lightdm"
    "lemurs"
    "ly"
  ];
in
{
  options.modules.gui = {
    x11 = {
      enable = mkEnableOption "Enable X11 server.";
      wm = mkOption {
        type = listOf str;
        default = [ ];
        description = "Wayland compositor(s) to use.";
      };
    };
    wayland = {
      enable = mkEnableOption "Enable wayland server.";
      wm = mkOption {
        type = listOf str;
        default = [ "niri" ];
        description = "Wayland compositor(s) to use.";
      };
    };
    login = {
      manager = mkOption {
        type = enum manager;
        description = "Login manager to use.";
      };
    };
  };

  config = mkMerge [
    #: DISPLAY SERVERS
    {
      programs.dconf.enable = true;

      services.xserver = {
        inherit (cfg.x11) enable;
        excludePackages = [ pkgs.xterm ];
        /**
          wallpaper via desktop manager
          images in `~/.background-image`
          mode: center, fill, scale, max, tile
        */
        desktopManager.wallpaper.mode = mkDefault "scale";
      };
    }
    (mkIf cfg.wayland.enable {
      /**
        FIXME: Niri modules enabled `services.gnome.gnome-keyring`
        which enabled `services.gnome.gcr-ssh-agent.enable'
        and causes the failed assertion:

          `programs.ssh.startAgent' and
          `services.gnome.gcr-ssh-agent.enable'
          cannot both be enabled at the sametime.

        `services.gnome.gcr-ssh-agent.enable` is set to false
        in `flake/modules/nixos/services/ssh` to temporatily
        fix the failed assertion.
      */
      programs.niri = {
        enable = elem "niri" cfg.wayland.wm;
        package = pkgs.unstable.niri;
      };

      environment.sessionVariables.NIXOS_OZONE_WL = "1";
      security.polkit.enable = true;
    })

    #: DISPLAY MANAGERS
    {
      services.displayManager = {
        enable = cfg.login != null;
        autoLogin = {
          enable = true;
          user = elemAt hostConfig.userList 0;
        };
      };
    }
    (mkIf (cfg.login == "lightdm" && cfg.x11.enable) nixos.services.display-managers.lightdm)
    (mkIf (cfg.login == "lemurs") nixos.services.display-managers.lemurs)
    (mkIf (cfg.login == "ly") nixos.services.display-managers.ly)
  ];
}
