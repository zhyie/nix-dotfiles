{ config, pkgs, dots, ... }:

let
  cwd = "${config.home.homeDirectory}/.dotfiles";
in
{
  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Light";
      size = "32x32";
    };
    configFile = "${cwd}/${dots.dunst}/dunstrc";
  };
}


