{ lib, pkgs, ... }:

let
  inherit (lib) attrValues;
in

{
  services.flameshot = {
    enable = true;
    package = pkgs.flameshot;
  };
}
