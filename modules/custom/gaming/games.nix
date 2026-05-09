{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkOption
    types
    mkMerge
    mkIf
    elem
    ;
  inherit (types)
    listOf
    str
    path
    ;

  cfg = config.modules.gaming;
in
{
  imports = [ cfg.flatpak ];

  options.modules.gaming = {
    games = mkOption {
      type = listOf str;
      default = [ ];
      description = "List of games to install.";
    };
    flatpak = mkOption {
      type = path;
      default = null;
      description = "Path to flatpak configuration directory.";
    };
  };

  config = mkMerge [
    (mkIf (elem "proton" cfg.games) {
      environment.systemPackages = [
        pkgs.unstable.protonup-qt
        pkgs.unstable.protonup-rs
      ];
    })
    (mkIf (elem "heroic" cfg.games) { environment.systemPackages = [ pkgs.unstable.heroic ]; })
    (mkIf (elem "faugus" cfg.games) { environment.systemPackages = [ pkgs.unstable.faugus-launcher ]; })
    (mkIf (elem "roblox" cfg.games) cfg.flatpak.roblox)
    (mkIf (elem "mcpe" cfg.games) cfg.flatpak.mcpe)
  ];
}
