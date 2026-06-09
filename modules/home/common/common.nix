{
  osConfig,
  pkgs,
  ...
}:
{
  modules.xserver.enable = osConfig.modules.xserver.enable;
  modules.wayland.enable = osConfig.modules.wayland.enable;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [ "gtk" ];
  };
}
