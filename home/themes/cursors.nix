{ pkgs, ... }:

{
  home.packages = with pkgs; [ catppuccin-cursors.mochaMauve ];

  # xsession = { enable = true; };

  home.pointerCursor = {
    enable = true;
    package = pkgs.catppuccin-cursors.mochaMauve;
    name = "catppuccin-mocha-mauve-cursors";
    size = 24;

    x11 = {
      enable = true;
      defaultCursor = "left_ptr";
    };
    gtk.enable = true;
  };
}
