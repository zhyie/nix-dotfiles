{ pkgs, ... }:

{
  # home.file.".config/picom" = {
  #   source = ../config/picom;
  # };

  services.picom = {
    enable = true;
    package = pkgs.picom;

    # SHADOW SETTINGS
    shadow = true;
    shadowOpacity = 0.75;
    shadowOffsets = [ (-7) (-7) ];
    #shadowExclude = [ "" "" ];

    # FADING SETTINGS
    fade = true;
    fadeSteps = [ 0.03 0.03 ];
    fadeDelta = 5;
    #fadeExclude = [ "" "" ];

    # OPACITY SETTINGS
    activeOpacity = 0.9;
    inactiveOpacity = 0.5;
    menuOpacity = 0.9;
    #opacityRules = [  ];

    # GENERAL SETTINGS
    vSync = true;
    backend = "glx";
    #wintypes = [  ];
  };
}
