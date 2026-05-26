{ inputs, ... }:
{
  services.dunst = {
    enable = true;
    configFile = "${inputs.dotfiles}/dunst/dunstrc";
  };
}
