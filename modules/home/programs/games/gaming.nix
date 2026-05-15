{
  config,
  lib,
  inputs,
  ...
}:
{
  imports =
    let
      inherit (inputs.self.modules.common) gaming modules;
    in
    [
      gaming
      modules
    ];

  config =
    let
      inherit (lib)
        mkIf
        ;
      cfg = config.modules.gaming;

      # installPkgs =
      #   version: mapAttrsToList (_: c: optionals (c.enable && c.version == version) c.packages) cfg.games;

      # installPkgs = mapAttrsToList (
      #   _: c: optionals (c.enable && c.version == "nixpkgs") c.packages
      # ) cfg.games;
      # flatpakPkgs = mapAttrsToList (
      #   _: c: optionals (c.enable && c.version == "flatpak") c.packages
      # ) cfg.games;
    in
    mkIf (cfg.env == "home") { home.packages = cfg.packages.nixpkgs; };
  # mkMerge [
  #   (
  #     mkIf (cfg.env == "home") {
  #       #: Install game nixpkgs
  #       home.packages = installPkgs "nixpkgs";
  #     }
  #     // {
  #       #: Install game flatpak
  #       services.flatpak.packages = installPkgs "flatpak";
  #     }
  #   )
  # ];
}
