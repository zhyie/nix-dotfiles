{
  config,
  lib,
  inputs,
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

  cfg = config.modules.graphical;
  importModule = module: module args;
in
{
  imports = [
    inputs.self.modules.common.flatpak
    nixos.services.flatpak
  ];

  options.modules.graphical = {
    xserver = {
      enable = mkEnableOption "Enable X11 server.";
      wm = mkOption {
        type = listOf str;
        default = [ ];
        description = "Wayland compositor(s) to use.";
      };
      dwm = lib.mkEnableOption "Enable dwm.";
    };
    wayland = {
      enable = mkEnableOption "Enable wayland server.";
      wm = mkOption {
        type = listOf str;
        default = [ "niri" ];
        description = "Wayland compositor(s) to use.";
      };
      niri = lib.mkEnableOption "Enable niri.";
    };
    # _xserver = lib.mkOption {
    #   type = lib.types.listOf lib.types.str;
    #   default = [ "dwm" ];
    #   description = "Xserver graphical environment.";
    # };
    # _wayland = lib.mkOption {
    #   type = lib.types.listOf lib.types.str;
    #   default = [ "niri" ];
    #   description = "Xserver graphical environment.";
    # };

    display = {
      enable = mkEnableOption "Enable display manager.";
      manager = mkOption {
        type = nullOr (enum [
          "lightdm"
          "lemurs"
          "ly"
        ]);
        default = null;
        description = "Display manager to use.";
      };
    };
  };

  /**
    IMPLEMENTATION
  */
  config = mkMerge [
    {
      modules.graphical.enable = true;
      modules.xserver.enable = cfg.xserver.enable;
      modules.wayland.enable = cfg.wayland.enable;

      programs.dconf.enable = true;
    }
    # (
    #   mkIf cfg._xserver != [ ] {
    #     modules.xserver.enable = true;
    #   }
    # )

    /**
      DISPLAY SERVERS
    */
    #: XSERVER
    (mkIf cfg.xserver.enable (importModule nixos.xserver.default))
    (mkIf (cfg.xserver.enable && config.modules.laptop.enable) (
      (importModule nixos.xserver.xautolock) // (importModule nixos.xserver.xscreensaver)
    ))
    #: WAYLAND
    (mkIf cfg.wayland.enable nixos.wayland.default)
    (mkIf (elem "niri" cfg.wayland.wm) (importModule nixos.wayland.niri))

    /**
      DISPLAY MANAGERS
    */
    (mkIf (cfg.display.manager == "lightdm" && cfg.xserver.enable) nixos.display-managers.lightdm)
    (mkIf (cfg.display.manager != "lightdm") nixos.display-managers.default)
    (mkIf (cfg.display.manager == "lemurs") nixos.display-managers.lemurs)
    (mkIf (cfg.display.manager == "ly") (importModule nixos.display-managers.ly))
  ];
}
