{ pkgs, ... }:
{
  imports = [ ./backlight.nix ];

  modules.backlight = {
    enable = true;
    package = pkgs.brightnessctl;

    flags = {
      minimum = "-n";
      increase = "-s";
      decrease = "-s";
    };
  };
}
