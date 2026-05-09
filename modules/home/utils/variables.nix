{ lib, ... }:

let
  inherit (lib) mkOption types;
  inherit (types) str;
in
{
  options.vars = {
    path = mkOption {
      type = str;
      default = "flake";
      description = "Path of the nixos flake directory.";
    };

    name = mkOption {
      type = str;
      description = "User name.";
    };

    email = {
      git = mkOption {
        type = str;
        description = "Git email.";
      };
    };
  };
}
