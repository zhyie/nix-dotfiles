{ pkgs, ... }:

{
  # home.packages = [ pkgs.catppuccin-cursors.mochaMauve ];
  # xsession = { enable = true; };

  home.pointerCursor = {
    enable = true;
    package = pkgs.catppuccin-cursors.latteFlamingo;
    name = "catppuccin-latte-flamingo-cursors";
    size = 24;

    x11 = {
      enable = true;
      defaultCursor = "left_ptr";
    };
    gtk.enable = true;
  };
}
