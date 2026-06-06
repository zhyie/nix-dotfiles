{
  config,
  lib,
  home,
  ...
}:
{
  imports = [ home.services.flatpak ];

  home.packages = config.modules.gaming.packages.nixpkgs;

  modules.gaming.games = {
    proton.enable = lib.mkDefault true;
    heroic.enable = lib.mkDefault true;
    faugus.enable = lib.mkDefault true;
    roblox.enable = lib.mkDefault true;
  };
}
