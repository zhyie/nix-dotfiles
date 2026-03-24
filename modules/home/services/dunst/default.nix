{ pkgs, inputs, ... }:
{
  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
      size = "32x32";
    };

    configFile = inputs.dotfiles + "/dunst/dunstrc";
  };
}
