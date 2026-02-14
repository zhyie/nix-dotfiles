{ pkgs, ... }:

{

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;

    package = pkgs.catppuccin-cursors;
    name = "Catppuccin-mochaPink-Cursors";
    size = 24;
  };

}
