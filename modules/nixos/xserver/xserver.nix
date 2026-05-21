{ pkgs, lib, ... }:
{
  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];
    /**
      wallpaper via desktop manager
      images in `~/.background-image`
      mode: center, fill, scale, max, tile
    */
    desktopManager.wallpaper.mode = lib.mkDefault "scale";
  };
}
