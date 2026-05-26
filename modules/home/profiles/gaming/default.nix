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

  modules.gaming = {
    env = "home";

    games =
      let
        inherit (lib) mkDefault;
      in
      {
        proton.enable = mkDefault true;
        heroic.enable = mkDefault true;
        faugus.enable = mkDefault true;
        roblox.enable = mkDefault true;
        mcpe.enable = mkDefault true;
      };
  };
}
