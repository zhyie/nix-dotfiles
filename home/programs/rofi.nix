{ pkgs, ... }:

{

  home.packages = with pkgs; [ rofi ];

  home.file.".config/rofi" = {
    source = ../../config/rofi;
    recursive = true;
  };

  programs.rofi = {
    enable = true;
    modes = [
      "drun"
      "run"
      "window"
    ];
    extraConfig = {
      show-icons = true;
    };
  };

}
