{ pkgs, lib, name, type, ... }:

let
  link = config.lib.file.mkOutOfStoreSymlink;
  path = config.home.homeDirectory;

  df = ".dotfiles/config/${name}";
  ft = "${type}";
in

{
  dir = lib.genAttrs dir (n: );

  xdg.configFile."${name}" = {
    source = link "${path}/${df}";
    recursive = true;
  };

  file = xdg.configFile."${name}" = {
    source = link "${path}/${df}.${ft}";
  };
  # configDir = xdg.configFile."${name}" = {
  #   source = link "${path}/${df}";
  #   recursive = true;
  # };
  #
  # configFile = xdg.configFile."${name}" = {
  #   source = link "${path}/${df}.${ft}";
  # };
}
