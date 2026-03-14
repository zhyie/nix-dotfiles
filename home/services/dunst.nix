{ config, pkgs, ... }:
let
  out = config.lib.file.mkOutOfStoreSymlink;
in
{
  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Light";
      size = "32x32";
    };
  };

  xdg.configFile.dunst = {
    source = "../../dotfiles/dunst";
    recursive = true;
  };
}
