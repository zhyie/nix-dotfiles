{ config, lib, ... }:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    optionals
    concatMap
    attrValues
    mkDefault
    any
    ;
in
{
  options.modules.gaming = {
    enable = mkEnableOption "Enable gaming modules.";
    flatpak = mkEnableOption "Use flatpak.";

    env = mkOption {
      type = types.enum [
        "home"
        "nixos"
      ];
      default = "nixos";
      description = "Environment the packages will install to.";
    };

    #: Placeholders for the list of packages to install.
    packages = {
      nixpkgs = mkOption {
        type = types.nullOr (types.listOf types.package);
        description = "Final list of packages.";
      };
      flatpaks = mkOption {
        type = types.nullOr (types.listOf types.str);
        description = "Final list of packages.";
      };
    };

    #: `games.<gameName>.<gameConfig>`
    # games = genAttrs gameList gameConfig;
    games = mkOption {
      type = types.attrsOf (
        types.submodule (
          { name, ... }:
          {
            options = {
              enable = mkEnableOption "Enable ${name}.";
              version = mkOption {
                type = types.enum [
                  "nixpkgs"
                  "flatpak"
                ];
                default = "nixpkgs";
                description = "Package version to use.";
              };
              packages = mkOption {
                type = types.nullOr (types.listOf (types.either types.package types.str));
                default = [ ];
                description = "List of packages for this game.";
              };
            };
          }
        )
      );
      default = { };
      description = "Games with config.";
    };
  };

  config =
    let
      cfg = config.modules.gaming;

      installPkgs =
        version:
        concatMap (game: optionals (game.enable && game.version == version) game.packages) (
          attrValues cfg.games
        );

      # gameConfig = attrValues cfg.games;
      # checkFlatpak = c: c.enable && c.version == "flatpak";
      checkFlatpak = any (game: game.enable && game.version == "flatpak") (
        attrValues config.modules.gaming.games
      );
    in
    {
      modules.gaming.flatpak = mkDefault checkFlatpak;
      modules.gaming.packages.nixpkgs = installPkgs "nixpkgs";
      modules.gaming.packages.flatpaks = installPkgs "flatpak";

      modules.flatpak.enable = mkDefault cfg.flatpak;
      services.flatpak.packages = cfg.packages.flatpaks;
    };
}
