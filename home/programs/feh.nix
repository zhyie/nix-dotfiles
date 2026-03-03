{ pkgs, ... }:

let
  setXdg = import ../../lib/xdg.nix;
in

{
  # home.file.".config/feh" = {
  #   source = builtins.readFile ../../config/feh;
  #   recursive = true;
  # };

  # setXdg.configFile = {
  #   name = "feh";
  #   type = ".conf";
  # };

  programs.feh = {
    enable = true;
    package = pkgs.feh;

    # Mouse buttons
    buttons = {
      zoom_in = "C-4";
      zoom_out = "C-5";
    };

    # Key binds
    keybindings = {
      next_img = [ "l" "Right" ];
      prev_img = [ "h" "Left" ];


    };

    # Themes
    # themes = {};
  };

}
