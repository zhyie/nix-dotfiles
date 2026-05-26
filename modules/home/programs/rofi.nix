{ pkgs, ... }:
{
  home.packages =
    let
      rofi = pkgs.rofi.override {
        plugins = builtins.attrValues {
          inherit (pkgs)
            rofi-calc
            rofi-emoji
            ;
        };
      };
    in
    [ rofi ]
    ++ (builtins.attrValues {
      inherit (pkgs)
        rofi-power-menu
        rofi-mpd
        rofi-rbw-x11
        rofi-obsidian
        keepmenu
        ;
    });
}
