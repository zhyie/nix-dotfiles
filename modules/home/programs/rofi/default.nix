{ pkgs, ... }:

let
  rofi = pkgs.rofi.override {
    plugins = builtins.attrValues {
      inherit (pkgs)
        rofi-power-menu
        rofi-calc
        rofi-emoji
        rofi-mpd
        rofi-rbw-x11
        rofi-obsidian
        keepmenu
        ;
    };
  };
in
{
  home.packages = [ rofi ];
  # programs.rofi = {
  #   enable = true;
  #   package = pkgs.rofi.override {
  #     plugins = builtins.attrValues {
  #       inherit (pkgs)
  #         rofi-power-menu
  #         rofi-calc
  #         rofi-emoji
  #         rofi-mpd
  #         rofi-rbw-x11
  #         rofi-obsidian
  #         keepmenu
  #         ;
  #     };
  #   };
  # };
}
