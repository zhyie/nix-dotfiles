{ config, pkgs, ... }:

{

  home.packages = with pkgs; [ rofi ];

  programs.rofi = {
    enable = true;
    theme = "sidebar";
    font = "sans-serif";
    package = pkgs.rofi;
    modes = [
      "drun"
      "run"
      "window"
      "ssh"  
    ];
    extraConfig = {
      show-icons = true;
    };
  };

}
