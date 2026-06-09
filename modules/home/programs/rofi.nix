{ pkgs, ... }:
{
  home.packages =
    let
      rofi = pkgs.rofi.override {
        plugins = builtins.attrValues {
          inherit (pkgs)
            rofi-calc
            rofi-emoji
            rofi-top
            rofi-file-browser
            ;
        };
      };
    in
    [ rofi ]
    ++ (builtins.attrValues {
      inherit (pkgs)
        rofi-power-menu
        rofi-bluetooth
        rofi-network-manager
        rofi-mpd
        ;
    });
}
