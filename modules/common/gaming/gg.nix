{ lib, ... }:
{
  options.modules.gaming =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      homeEnv = mkEnableOption "Install pkgs in home manager.";
      flatpak = mkOption {
        type = types.str;
        default = null;
        description = "Path to flatpak configuration directory.";
      };

      proton = mkEnableOption "GUI to install and update proton client.";
      heroic = mkEnableOption "Launcher for GOG and Epic Games.";
      faugus = mkEnableOption "Simple and lightweight launcher.";
      roblox = mkEnableOption "Sober, a roblox client from flatpak.";
      mcpe = mkEnableOption "MCPE Launcher from flatpak.";
    };
}
