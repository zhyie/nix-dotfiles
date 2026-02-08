{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;

    ########################################
    #            WINDOW MANAGER            #
    ########################################
    windowManager = {

      ##### DWM as window manager ###############
      dwm = {
        enable = true;
        package = pkgs.dwm.overrideAttrs {
          src = ../../config/dwm;
        };
      };

      ##### OXWM as window manager ###############
      # oxwm = {};
    };

    ########################################
    #            DISPLAY MANAGER           #
    ########################################
    displayManager = {
      # LightDM as display manager
      lightdm.greeters.gtk = {
        enable = true;

        # little widget in login
        indicators = [ "~host" "~spacer" "~clock" "~spacer" "~a11y" "~session" "~power" ];
        clock-format = "%a %b %d %H:%M";

        # display manager themes
        theme = { package = pkgs.rose-pine-gtk-theme; name = "rose-pine-moon-gtk"; };
        iconTheme = { package = pkgs.papirus-icon-theme; name = "Papirus-Dark"; };
        cursorTheme = { package  pkgs.bibata-cursors; name = "Bibata-Modern-Classic"; size = "32"; };
      };

      # commands to run before window manager or desktop starts
      #
      # dwm-status to enable status for dwm
      sessionCommands = ''
        feh --bg-scale /home/zhyie/Pictures/backgrounds/12259316.jpg
        dwm-status /home/zhyie/.dotfiles/home/services/dwm-status/dwm-status.json
      '';
    };

  };
}
