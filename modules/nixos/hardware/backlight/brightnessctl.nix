{ pkgs, ... }:
{
  imports = [ ./backlight.nix ];

  modules.backlight = {
    package = pkgs.brightnessctl;

    flags = {
      minimum = "--min-value";
      increase = "set";
      decrease = "set";
    };
  };
}
