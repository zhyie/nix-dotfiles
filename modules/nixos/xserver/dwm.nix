{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.suckless.nixosModules.default ];

  config = {
    suckless = {
      enable = lib.elem "dwm" config.modules.gui.xserver.wm;
      dwm = {
        enable = lib.mkDefault true;
        /**
          Packages available for DWM:
            - dwm
            - flexipatch

          where,
            dwm         - a minimal setup
            flexipatch  - extensible setup
        */
        package = lib.mkDefault "dwm";
      };
    };
  };
}
