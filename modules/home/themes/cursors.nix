{ pkgs, ... }:
{
  home.pointerCursor = {
    enable = true;
    package = pkgs.catppuccin-cursors.latteFlamingo;
    name = "catppuccin-latte-flamingo-cursors";
    size = 24;

    x11.enable = true;
    gtk.enable = true;
  };
}
