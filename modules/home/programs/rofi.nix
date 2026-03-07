{ pkgs, ... }:

{

  home.packages = with pkgs; [ rofi ];

  home.file.".config/rofi" = {
    source = ../../../dotfiles/rofi;
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
