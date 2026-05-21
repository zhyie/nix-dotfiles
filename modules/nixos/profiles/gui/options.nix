{
  config,
  lib,
  pkgs,
  nixos,
  ...
}@args:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkMerge
    mkIf
    elem
    ;
  inherit (types)
    listOf
    str
    enum
    nullOr
    ;

  cfg = config.modules.gui;
  importModule = module: module args;
in
{
  options.modules.gui = {
    xserver = {
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
    display = {
      enable = mkEnableOption "Enable display manager.";
      manager = mkOption {
        type = nullOr (enum [
          "lightdm"
          "lemurs"
          "ly"
        ]);
        default = "ly";
        description = "Display manager to use.";
      };
    };
  };

  /**
    IMPLEMENTATION
  */
  config = mkMerge [
    {
      modules.xserver.enable = cfg.xserver.enable;
      modules.wayland.enable = cfg.wayland.enable;

      programs.dconf.enable = true;
    }

    /**
      DISPLAY SERVERS
    */
    #: XSERVER
    (mkIf cfg.xserver.enable (importModule nixos.xserver.default))
    (mkIf (cfg.xserver.enable && config.modules.laptop.enable) (importModule nixos.xserver.default))
    #: WAYLAND
    (mkIf cfg.wayland.enable nixos.wayland.default)
    (mkIf (elem "niri" cfg.wayland.wm) (nixos.wayland.niri { inherit pkgs; }))

    /**
      DISPLAY MANAGERS
    */
    (mkIf (cfg.display.manager == "lightdm" && cfg.xserver.enable) nixos.services.lightdm)
    (mkIf (cfg.display.manager != "lightdm") nixos.services.display-managers.default)
    (mkIf (cfg.display.manager == "lemurs") nixos.services.lemurs)
    (mkIf (cfg.display.manager == "ly") nixos.services.ly)
  ];
}
