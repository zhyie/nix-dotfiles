{ lib, home, ... }:

let
  inherit (lib) mkDefault;
  inherit (home.programs) flatpak;
in
{
  imports = [
    ./gaming.nix
    flatpak
  ];

  modules = {
    gaming = {
      env = "home";
      inherit flatpak;

      games = {
        proton.enable = mkDefault true;
        heroic.enable = mkDefault true;
        faugus.enable = mkDefault true;
        roblox.enable = mkDefault true;
        mcpe.enable = mkDefault true;
      };
    };
  };
}
