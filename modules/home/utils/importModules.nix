{ config, ... }:

let
  inherit (config.mods.home) category names;

  importModules = lib.genAttrs config.mods.home (mod: import homeModules.${category}.${names})
in
{
  imports = builtins.attrValues importModules;
}
