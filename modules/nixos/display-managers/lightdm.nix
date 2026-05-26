{ config, ... }:
{
  assertions = [
    {
      assertion = config.graphical.xserver.enable;
      message = ''
        LightDM relies on X11. Enable X11 through any of these options:
          - `modules.graphical.xserver.enable = true;`
          - `services.xserver.enable = true;`
      '';
    }
  ];

  services.xserver = {
    enable = true;
    displayManager = {
      #: LightDM as display manager
      lightdm.greeters.gtk = {
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
  };
}
