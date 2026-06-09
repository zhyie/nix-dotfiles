{ config, lib, ... }:
{
  environment.sessionVariables = lib.optionalAttrs config.modules.wayland.enable {
    NIXOS_OZONE_WL = "1";
  };

  security.polkit.enable = lib.mkDefault config.modules.wayland.enable;
}
