{ inputs, lib, ... }:
{
  imports = [ inputs.suckless.nixosModules.default ];

  suckless = {
    enable = true;
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
}
