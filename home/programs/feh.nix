{ pkgs, ... }:

{
  #home.file.".config/feh" = {
   # source = ../../config/feh;
  #};

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
