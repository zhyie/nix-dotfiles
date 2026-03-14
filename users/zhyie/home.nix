{ lib, pkgs, home, dots, scripts, ... }:

let
  inherit (lib) attrValues;
  sc = scripts { inherit pkgs; };

  # outLink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.file = {
    ".gitconfig" = { source = builtins.toString ./.gitconfig; };
  };

  dotfiles.configFiles = [
    "picom" "kitty" "rofi" "yazi"
    # "dunst"
  ];

  imports = [
    home.programs.default
    home.services.default
    home.themes.default
    dots.dotfiles
  ];
  home.packages = attrValues {
    inherit (sc) hello;

    inherit (pkgs)
    mediainfo
    imagemagick
    trash-cli
    nushell
    ;
  };
}
