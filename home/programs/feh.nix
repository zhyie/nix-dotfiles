{ pkgs, ... }:

{

  home.packages = with pkgs; [ feh ];

  #home.file.".config/feh" = {
   # source = ../../config/feh;
  #};

}
