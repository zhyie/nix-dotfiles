{ ... }:
{
  services.xserver = {
    enable = true;

    # DISPLAY MANAGER
    displayManager = {
      # LightDM as display manager
      lightdm.greeters.gtk = {
        enable = true;
        # little widget in login
        indicators = [
          "~host"
          "~spacer"
          "~clock"
          "~spacer"
          "~a11y"
          "~session"
          "~power"
        ];
        # output: Sun Jan 01 23:59
        clock-format = "%b %d %H:%M:%S (%a)";
      };
    };

    # WALLPAPER VIA DESKTOP MANAGER
    # Images in `~/.background-image`
    # mode: center, fill, scale, max, tile
    desktopManager.wallpaper.mode = "scale";
  };
}
