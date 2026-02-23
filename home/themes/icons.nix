{ pkgs, ... }:

{
  home.packages = with pkgs; [ papirus-icon-theme ];

  gtk.iconTheme = {
    package = pkgs.papirus-icon-theme;
    name = "Papirus-Dark";
  };
}
