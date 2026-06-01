{ lib, ... }:
{
  services.xserver = {
    enable = true;
    autoRepeatDelay = 300;
    autoRepeatInterval = 45;

    /**
      wallpaper via desktop manager
      images in `~/.background-image`
      mode: center, fill, scale, max, tile
    */
    desktopManager.wallpaper.mode = lib.mkDefault "scale";
  };
}
