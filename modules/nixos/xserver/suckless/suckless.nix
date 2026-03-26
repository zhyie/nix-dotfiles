{ config, lib, ... }:
let
  inherit (lib)
    mkEnable
    mkIf
    mkMerge
    mkDefault
    ;

  cfg = config.suckless;
in
{
  options.suckless = {
    allTools = mkEnable "Enable all suckless tools";
    dwmOnly = mkEnable "Enable DWM only with slstatus";
    extraTools = mkEnable "Enable the tools only";
  };

  config = mkMerge [
    (mkIf cfg.allTools {
      suckless.tools = {
        dwm = mkDefault true;
        dmenu = mkDefault true;
        slstatus = mkDefault true;
        st = mkDefault true;
      };
    })
    (mkIf cfg.dwmOnly {
      suckless.tools = {
        dwm = mkDefault true;
        slstatus = mkDefault true;
      };
    })
    (mkIf cfg.allTools {
      suckless.tools = {
        dmenu = mkDefault true;
        st = mkDefault true;
      };
    })
  ];
}
