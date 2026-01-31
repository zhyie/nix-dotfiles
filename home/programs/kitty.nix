{ pkgs, ... }:

{

  # Install kitty packages
  home.packages = with pkgs; [ kitty ];
  home.file.".config/kitty" = {
    source = ../../config/kitty;
    recursive = true;
  };

  # Configure kitty
  programs.kitty = {
    enable = true;
  };

}
