{
  config,
  lib,
  pkgs,
  inputs,
  nixos,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkMerge
    mkIf
    ;

  args = {
    inherit
      config
      lib
      pkgs
      inputs
      nixos
      ;
  };
  cfg = config.modules.graphical;
  isEnable = attr: lib.any (c: c) (lib.attrValues attr);
in
{
  imports = [
    inputs.self.modules.common.flatpak
    nixos.services.flatpak
  ];

  options.modules.graphical = {
    xserver = {
      enable = mkEnableOption "Enable X11 server.";
      dwm = mkEnableOption "Enable dwm.";
    };

    wayland = {
      enable = mkEnableOption "Enable wayland server.";
      niri = mkEnableOption "Enable niri.";
    };

    display = {
      enable = mkEnableOption "Enable display manager.";
      manager = mkOption {
        type = types.nullOr (
          types.enum [
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
  config = mkMerge [
    {
      #: Enable global options.
      modules.graphical.enable = true;
      modules.xserver.enable = cfg.xserver.enable;
      modules.wayland.enable = cfg.wayland.enable;

      programs.dconf.enable = true;
    }

    /**
      DISPLAY SERVERS
    */
    #: XSERVER
    (mkIf (isEnable cfg.xserver) (nixos.xserver.default args))
    # (mkIf cfg.xserver.enable (nixos.xserver.default args))
    (mkIf (cfg.xserver.enable && config.modules.laptop.enable) (
      (nixos.xserver.xautolock args) // (nixos.xserver.xscreensaver args)
    ))
    #: WAYLAND
    (mkIf (isEnable cfg.wayland) (nixos.xserver.default args))
    # (mkIf cfg.wayland.enable (nixos.wayland.default args))
    (mkIf cfg.wayland.niri (nixos.wayland.niri args))

    /**
      DISPLAY MANAGERS
    */
    #: Display manager that relies on xserver.
    (mkIf (cfg.display.manager == "lightdm" && cfg.xserver.enable) (
      nixos.display-managers.lightdm args
    ))
    #: Independent display manager.
    (mkIf (cfg.display.manager != "lightdm") (nixos.display-managers.default args))
    (mkIf (cfg.display.manager == "lemurs") (nixos.display-managers.lemurs args))
    (mkIf (cfg.display.manager == "ly") (nixos.display-managers.ly args))
  ];
}
