{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.wayland = {
    niri = lib.mkEnableOption "Niri modules";
  };

  config = lib.mkIf config.modules.wayland.niri (import ./niri.nix { inherit pkgs; });
}
