{ ... }:
{
  programs.feh = {
    enable = true;
    # Mouse buttons
    buttons = {
      rotate = "C-1";
      blur = "C-3";
      reload = "C-2";
      zoom_in = "C-4";
      zoom_out = "C-5";
    };
    # Key binds
    keybindings = {
      next_img = [
        "l"
        "Right"
      ];
      prev_img = [
        "h"
        "Left"
      ];
      scroll_left = [
        "H"
        "S-Left"
      ];
      scroll_right = [
        "L"
        "S-Right"
      ];
      scroll_up = [
        "K"
        "S-Up"
      ];
      scroll_down = [
        "J"
        "S-Down"
      ];
      toggle_pause = "p";
      save_filelist = "S";
      # menu keys
      menu_up = "k";
      menu_down = "j";
      menu_left = "h";
      menu_right = "l";
    };
    # Themes
    themes = {
      booth = [
        "--full-screen"
        "--hide-pointer"
        "--slideshow-delay"
        "20"
      ];
      example = [
        "--info"
        "foo bar"
      ];
      feh = [
        "--image-bg"
        "black"
      ];
      imagemap = [
        "-rVq"
        "--thumb-width"
        "40"
        "--thumb-height"
        "30"
        "--index-info"
        "%n\\n%wx%h"
      ];
      present = [
        "--full-screen"
        "--sort"
        "name"
        "--hide-pointer"
      ];
      webcam = [
        "--multiwindow"
        "--reload"
        "20"
      ];
    };
  };
}
