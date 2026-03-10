{ dots, pkgs, ... }:

{
  xdg.configFile = dots.configFile "yazi";

  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
  };
}
