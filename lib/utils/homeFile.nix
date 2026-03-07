{ config, lib, dots, ... }:

let
  inherit (lib) mkDefault;

  homepath = config.home.homeDirectory;
in

name: cfg:
  "${name}" = {
    enable = mkDefault true;
    target = mkDefault "${homepath}/${name}";
    source = mkDefault dots.${name};
    recursive = mkDefault true;
    force = mkDefault false;
    ignorelinks = mkDefault false;
    executable = mkDefault null;
    onChange = mkDefault null;
    text = mkDefault null;
  } // cfg;
}
