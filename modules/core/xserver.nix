{ pkgs, ... }:

{
  # imports = [ ../suckless ];

  services.xserver = {
    enable = true;

    ########################################
    #            WINDOW MANAGER            #
    ########################################
    #
    # DWM as window manager is imported
    #

    ########################################
    #            DISPLAY MANAGER           #
    ########################################
    displayManager = {

      # LightDM as display manager
      lightdm.greeters.gtk = {
        enable = true;

        # little widget in login
        indicators = [
          "~host" "~spacer"
          "~clock" "~spacer"
          "~a11y" "~session" "~power"
        ];
        # man page for date:
        # https://www.man7.org/linux/man-pages/man1/date.1.html
        clock-format = "%a %b %d %H:%M"; # output: Sun Jan 01 23:59
      };
    };

    ########################################
    #    WALLPAPER VIA DESKTOP MANAGER     #
    ########################################
    # Image in `~/.background-image` is used as wallpaper.
    # `mode` option specifies the placement of the image on background
    # mode: center, fill, scale, max, tile
    desktopManager.wallpaper.mode = "scale";
  };
}
