{ config, pkgs, ... }:

{

  services.picom = {
    enable = true;
    backend = "glx";
    fade = true;

  };

}
