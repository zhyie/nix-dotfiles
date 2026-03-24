{ lib, ... }:

let
  inherit (lib) mkOption types;
in
{
  options.mods = {
    nixos = mkOption {
      type = types.listOf (
        types.submodule {
          option = {
            name = mkOption {
              type = types.str;
              default = "core";
              description = "Name of bundled modules.";
            };
            specific = mkOption {
              type = types.listOf;
              default = [ "default" ];
              description = "List of specific modules.";
            };
          };
        }
      );
      default = [
        {
          name = "common";
          specific = [ "default" ];
        }
      ];
      description = "List of modules for nixos configuration.";
    };

    home = mkOption {
      type = types.listOf (
        types.submodule {
          option = {
            name = mkOption {
              type = types.str;
              default = "core";
              description = "Name of bundled modules.";
            };
            specific = mkOption {
              type = types.listOf;
              default = [ "default" ];
              description = "List of specific modules.";
            };
          };
        }
      );
      default = [
        {
          name = "common";
          specific = [ "default" ];
        }
      ];
      description = "List of modules for home configuration.";
    };
  };
}
