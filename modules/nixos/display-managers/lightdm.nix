{ config, lib, ... }:
{
  services.xserver.displayManager.lightdm = {
    enable = lib.mkIf (
      config.modules.graphical.display.manager == "lightdm"
      || lib.any (c: c) (lib.attrValues config.modules.graphical.xserver)
    ) true;

    #: GTK Greeters
    greeters.gtk = {
      enable = true;

      #: little widget
      indicators = [
        "~host"
        "~spacer"
        "~clock"
        "~spacer"
        "~a11y"
        "~session"
        "~power"
      ];

      # output: Sun Jan 01 23:59:59
      clock-format = "%a %b %d %H:%M:%S";
    };
  };
}
