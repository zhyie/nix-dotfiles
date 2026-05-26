{
  config,
  lib,
  inputs,
  ...
}:
{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  #: Enable flatpak when apps are listed in appList or enabled.
  #: Will be read by nixos flatpak module to enable the system-wide settings.
  modules.flatpak.enable =
    config.modules.flatpak.appList != [ ]
    || lib.any (app: app.enable) (lib.attrValues config.modules.flatpak.apps);
}
