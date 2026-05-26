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
        "L"
        "S-Right"
      ];
      prev_img = [
        "H"
        "S-Left"
      ];
      scroll_left = [
        "h"
        "Left"
      ];
      scroll_right = [
        "l"
        "Right"
      ];
      scroll_up = [
        "k"
        "Up"
      ];
      scroll_down = [
        "j"
        "Down"
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
