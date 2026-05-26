{ lib, pkgs, ... }:
{
  imports = [ ./options.nix ];

  modules.gaming.games =
    let
      inherit (lib) mkDefault;
      inherit (pkgs.unstable)
        protonup-qt
        heroic
        faugus-launcher
        ;
    in
    {
      /**
        ----------------------------
        List of pre-configured games
        ----------------------------
        Current available options:

        <game> = {
          enable = <true or false>;
          packages = [ pkgs.<package-name> ];
          flatpak = <true or false>;
        };
        ----------------------------
        where:
          `enable` enable the game
          `version` pkgs version to use (nixpkgs or flatpak)
          `packages` list of packages of install
        ----------------------------
      */
      proton = {
        version = mkDefault "nixpkgs";
        packages = mkDefault [ protonup-qt ];
      };
      heroic = {
        version = mkDefault "nixpkgs";
        packages = mkDefault [ heroic ];
      };
      faugus = {
        version = mkDefault "nixpkgs";
        packages = mkDefault [ faugus-launcher ];
      };
      roblox = {
        version = mkDefault "flatpak";
        packages = mkDefault [ "org.vinegarhq.Sober" ];
      };
      mcpe = {
        version = mkDefault "flatpak";
        packages = mkDefault [ "io.mrarm.mcpelauncher" ];
      };
    };
}
