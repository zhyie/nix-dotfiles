{ lib, ... }:
{
  services.xserver = {
    enable = true;
    /**
      wallpaper via desktop manager
      images in `~/.background-image`
      mode: center, fill, scale, max, tile
    */
    desktopManager.wallpaper.mode = lib.mkDefault "scale";
  };
}
