{ pkgs, ... }:
{
  imports = [ ./backlight.nix ];

  modules.backlight = {
    package = pkgs.light;

    flags = {
      minimum = "-N";
      increase = "-A";
      decrease = "-U";
    };
  };
}
