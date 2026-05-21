{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs = {
    #: Hyfetch configuration
    hyfetch = {
      enable = config.modules.dev.enable;
      settings = {
        preset = "sapphic";
        mode = "rgb";
        auto_detect_light_dark = true;
        light_dark = "dark";
        lightness = 0.65;
        color_align = {
          mode = "horizontal";
        };
        backend = "neofetch";
        pride_month_disable = false;
      };
    };

    #: Initialize on login shell
    bash.initExtra = "${lib.getExe pkgs.hyfetch}";
  };
}
