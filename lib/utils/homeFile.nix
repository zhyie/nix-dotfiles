{ config, lib, dots, ... }:

let
  inherit (lib) mkDefault;

  homePath = config.home.homeDirectory;
  outLink = config.lib.file.mkOutOfStoreSymlink;
in

name: cfg:
  "${name}" = {
    enable = mkDefault true;
    target = mkDefault "${homePath}/${name}";
    source = mkDefault (outLink dots.${name});
    recursive = mkDefault true;
    force = mkDefault false;
    ignorelinks = mkDefault false;
    executable = mkDefault null;
    onChange = mkDefault null;
    text = mkDefault null;
  } // cfg;
}
