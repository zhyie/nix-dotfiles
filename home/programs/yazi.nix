{ config, dots, pkgs, ... }:

{
  # # xdg.configFile = dots.configFile { name = "yazi"; };
  # xdg.configFile."yazi" = {
  #   source = config.lib.file.mkOutOfStoreSymlink dots.yazi;
  #   recursive = true;
  # };

  home.packages = [ pkgs.yazi ];
  # programs.yazi = {
  #   enable = true;
  #   package = pkgs.yazi;
  # };
}
