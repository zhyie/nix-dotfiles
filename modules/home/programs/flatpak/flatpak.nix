{
  config,
  lib,
  inputs,
  ...
}:

let
  inherit (lib) optional elem;
  cfg = config.modules.flatpak;
in
{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  config = {
    services.flatpak = {
      enable = cfg.enable;

      packages = optional (elem "libreoffice" cfg.packages) [ "org.libreoffice.LibreOffice" ];
    };
  };
}
