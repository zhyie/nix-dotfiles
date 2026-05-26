{
  config,
  lib,
  inputs,
  nixos,
  ...
}:
{
  imports = [
    inputs.self.modules.common.gaming
    inputs.self.modules.common.flatpak
    nixos.services.flatpak
  ];

  config = lib.mkIf (config.modules.gaming.env == "nixos") {
    environment.systemPackages = config.modules.gaming.packages.nixpkgs;
  };
}
