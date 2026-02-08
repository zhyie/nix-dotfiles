{ config, pkgs, ... }:

{

  home.file.".config/picom" = {
    source = ../config/picom;
  };

  services.picom = {
    enable = true;
  };

}
