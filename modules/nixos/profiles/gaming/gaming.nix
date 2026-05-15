{
  config,
  lib,
  inputs,
  nixos,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.modules.gaming;
in
{
  imports = [
    inputs.self.modules.common.gaming
    nixos.services.flatpak
  ];

  config = mkIf (cfg.env == "nixos") { environment.systemPackages = cfg.packages.nixpkgs; };
}
