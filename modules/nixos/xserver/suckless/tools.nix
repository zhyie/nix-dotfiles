{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf mkMerge;
  inherit (inputs) suckless;

  dwm = pkgs.dwm.overrideAttrs (old: {
    src = (suckless + "/dwm");
    buildInputs = old.buildInputs ++ [ pkgs.libxcursor ];
  });

  st = pkgs.st.overrideAttrs (old: {
    src = (suckless + "/st");
    buildInputs = old.buildInputs ++ [ pkgs.libxcursor ];
  });

  dmenu = pkgs.dmenu.overrideAttrs { src = (suckless + "/dmenu"); };
  slstatus = pkgs.st.overrideAttrs { src = (suckless + "/slstatus"); };

  cfg = config.suckless.tools;
in
{
  options.suckless.tools = {
    dwm = mkEnableOption "dwm";
    slstatus = mkEnableOption "slstatus";
    dmenu = mkEnableOption "dmenu";
    st = mkEnableOption "st";
  };

  config = mkMerge [
    (mkIf cfg.dwm {
      services.xserver.windowManager.dwm = {
        enable = true;
        package = dwm;
      };
    })

    (mkIf cfg.dmenu {
      environment.systemPackages = [ dmenu ];
    })

    (mkIf cfg.st {
      environment.systemPackages = [ st ];
    })

    (mkIf cfg.slstatus {
      environment.systemPackages = [
        slstatus
        pkgs.alsa-utils
      ];
      services.xserver.windowManager.dwm = {
        extraSessionCommands = "${slstatus}/bin/slstatus &";
      };
    })
  ];
}
