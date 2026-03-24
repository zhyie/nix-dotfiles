{ pkgs, ... }:

{
  home.packages = with pkgs; [ papirus-icon-theme ];

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };
  };
}
