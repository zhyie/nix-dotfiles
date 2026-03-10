{ config, lib, pkgs, home, dots, scripts, ... }:

let
  inherit (lib) attrValues;
  sc = scripts { inherit pkgs; };

  outLink = config.lib.file.mkOutOfStoreSymlink;
in

{
  home.packages = attrValues {
    inherit (pkgs) qutebrowser;
    inherit (sc) hello;
  };

  home.file = {
    ".gitconfig" = { source = outLink ./.gitconfig; };
  };

  dotfiles.configFiles = [ "picom" "kitty" "rofi" "yazi" ];

  imports = [
    home.programs.default
    home.services.default
    home.themes.default
    dots.configFile
  ];
}
