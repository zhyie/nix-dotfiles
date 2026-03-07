{ lib, dots, ... }:

let
  inherit (lib) mkDefault;
in

name: cfg: {
  "${name}" = {
    enable = mkDefault true;
    target = mkDefault "${name}";
    source = mkDefault dots.${name};
    recursive = mkDefault true;
    force = mkDefault false;
    ignorelinks = mkDefault false;
    executable = mkDefault null;
    onChange = mkDefault null;
    text = mkDefault null;
  } // cfg;
}
