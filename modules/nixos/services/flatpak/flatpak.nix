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
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

  config = {
    services.flatpak = {
      enable = cfg.enable;
      remotes = [
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
      ];

      packages = optional (elem "libreoffice" cfg.packages) [ "org.libreoffice.LibreOffice" ];
    };
  };
}
