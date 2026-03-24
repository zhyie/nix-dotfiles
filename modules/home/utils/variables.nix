{ lib, ... }:

let
  inherit (lib) mkOption types;
  inherit (types)
    nullOr
    either
    str
    path
    ;
  # inherit (config.home) homeDirectory;
  #
  # cfg = config.vars;
in
{
  options.vars = {
    path = mkOption {
      type = nullOr (either str path);
      default = "flake";
      description = "Path of the nixos flake directory.";
    };

    name = mkOption {
      type = str;
      description = "User name.";
    };
  };
  #
  # config = {
  #   flakePath = "${homeDirectory}/${cfg.path}";
  # };
}
