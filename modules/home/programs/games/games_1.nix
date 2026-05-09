{
  config,
  lib,
  pkgs,
  home,
  ...
}:
let
  inherit (lib) mkMerge mkIf elem;
  inherit (home.programs) flatpak;

  cfg = config.modules.gaming;
in
{
  imports = [ flatpak ];

  options.modules.gaming = {
    games = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "List of games to install.";
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
    (mkIf (elem "roblox" cfg.games) flatpak.roblox)
    (mkIf (elem "mcpe" cfg.games) flatpak.mcpe)
  ];
}
