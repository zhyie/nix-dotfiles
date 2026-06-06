{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ inputs.suckless.nixosModules.default ];

  suckless = {
    dwm = {
      package = lib.mkDefault pkgs.dwm;
    };
  };
}
