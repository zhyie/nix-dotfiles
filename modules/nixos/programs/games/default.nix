{
  config,
  lib,
  pkgs,
  nixos,
  ...
}:
let
  inherit (lib) mkMerge mkIf elem;

  cfg = config.modules.nixos.gaming;
in
{
  imports = [ nixos.programs.flatpak ];

  options.modules.nixos.gaming = {
    games = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "List of games to enable";
    };
  };

  config = mkMerge [
    (mkIf (elem "steam" cfg.games) {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        gamescopeSession.enable = true;
      };
    })

    (mkIf (elem "lutris" cfg.games) {
      environment.systemPackages =
        let
          bottles = pkgs.bottles.override { removeWarningPopup = true; };
        in
        [
          bottles
          pkgs.unstable.heroic
          pkgs.unstable.faugus-launcher
        ];
    })

    (mkIf (elem "proton" cfg.games) {
      environment.systemPackages = [
        pkgs.unstable.protonup-qt
        pkgs.unstable.protonup-rs
      ];
    })

    (mkIf (elem "roblox" cfg.games) (nixos.programs.roblox))
    (mkIf (elem "mcpe" cfg.games) (nixos.programs.mcpe))
  ];
}
