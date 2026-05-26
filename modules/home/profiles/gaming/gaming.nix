{
  config,
  lib,
  inputs,
  home,
  ...
}:
{
  imports = [
    inputs.self.modules.common.gaming

    #: FLatpaks
    inputs.self.modules.common.flatpak
    home.programs.flatpak
  ];
  home.packages = config.modules.gaming.packages.nixpkgs;

  config = lib.mkIf (config.modules.gaming.env == "home") {
    home.packages = config.modules.gaming.packages.nixpkgs;
  };
}
