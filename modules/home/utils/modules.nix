{ lib, ... }:

let
  inherit (lib) mkOption types;
in
{
  options.mods = {
    home = mkOption {
      type = types.listOf (
        types.submodule {
          option = {
            category = mkOption {
              type = types.str;
              default = "core";
              description = "Name of bundled modules.";
            };
            names = mkOption {
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
