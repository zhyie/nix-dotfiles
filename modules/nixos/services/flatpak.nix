{
  config,
  lib,
  inputs,
  hostConfig,
  ...
}:
{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

  #: Enable nixos flatpak when home-manager flatpak is enabled.
  modules.flatpak.enable = lib.any (c: c) (
    lib.attrValues (
      lib.genAttrs hostConfig.users (u: config.home-manager.users.${u}.modules.flatpak.enable)
    )
  );

  #: portal definitions and DE provided configurations get linked
  environment.pathsToLink = lib.optionals config.services.flatpak.enable [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];
}
