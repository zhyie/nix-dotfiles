{ config, lib, ... }:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    optionals
    mapAttrsToList
    genAttrs
    ;
  inherit (types)
    str
    path
    listOf
    package
    enum
    nullOr
    either
    ;

  gameList = [
    "proton"
    "heroic"
    "faugus"
    "roblox"
    "mcpe"
  ];

  gameConfig = name: {
    enable = mkEnableOption "Enable ${name}.";

    version = mkOption {
      type = enum [
        "nixpkgs"
        "flatpak"
      ];
      default = "nixpkgs";
      description = "Package version to use.";
    };

    packages = mkOption {
      type = nullOr (listOf (either package str));
      default = [ ];
      description = "List of packages for this game.";
    };

    flatpak = mkOption {
      type = nullOr path;
      default = null;
      description = "Path to flatpak game config.";
    };
  };
in
{
  options.modules.gaming = {
    #: `games.<gameName>.<gameConfig>`
    games = genAttrs gameList gameConfig;

    env = mkOption {
      type = enum [
        "home"
        "nixos"
      ];
      default = "nixos";
      description = "Environment the packages will install to.";
    };

    flatpak = mkOption {
      type = nullOr path;
      default = null;
      description = "Path to flatpak configurations.";
    };

    #: Placeholders for the list of packages to install.
    packages = {
      nixpkgs = mkOption {
        type = nullOr (listOf package);
        description = "Final list of packages.";
      };
      flatpaks = mkOption {
        type = nullOr (listOf str);
        description = "Final list of packages.";
      };
    };
  };

  config =
    let
      inherit (lib) attrValues any flatten;
      cfg = config.modules.gaming;

      installPkgs =
        version:
        flatten (mapAttrsToList (_: c: optionals (c.enable && c.version == version) c.packages) cfg.games);

      gameConfig = attrValues cfg.games;
      checkFlatpak = c: c.enable && c.version == "flatpak";
    in
    {
      modules.gaming.packages.nixpkgs = installPkgs "nixpkgs";
      modules.gaming.packages.flatpaks = installPkgs "flatpak";

      modules.flatpak.enable = any checkFlatpak gameConfig;
      services.flatpak.packages = cfg.packages.flatpaks;
    };
}
