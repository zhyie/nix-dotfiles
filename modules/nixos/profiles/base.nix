{
  lib,
  nixos,
  hostConfig,
  ...
}:

let
  inherit (lib) elem optionals;
in
{
  imports = [
    nixos.common
    nixos.security.sops
  ]
  ++ (optionals (elem "zhyie" hostConfig.users) [ nixos.security.sudo ])
  #
  ;
}
