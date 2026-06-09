{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.yazi = {
    enable = true;
    package = pkgs.yazi.override { _7zz = pkgs._7zz-rar; };
    shellWrapperName = "y";
    enableBashIntegration = config.programs.bash.enable;
    enableNushellIntegration = config.programs.nushell.enable;
    extraPackages =
      builtins.attrValues {
        inherit (pkgs)
          ueberzugpp
          glow
          mediainfo
          trash-cli
          ;
      }
      ++ lib.optionals config.modules.xserver.enable [ pkgs.xclip ]
      ++ lib.optionals config.modules.wayland.enable [ pkgs.wl-clipboard ];
  };

  xdg = lib.optionalAttrs config.programs.yazi.enable {
    portal = {
      extraPortals = [ pkgs.xdg-desktop-portal-termfilechooser ];

      config.common = {
        "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      };
    };

    configFile."xdg-desktop-portal-termfilechooser/config" = {
      text = ''
        [filechooser]
        cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
        default_dir=$HOME

        env=TERMCMD=kitty
        env=PATH="$PATH:/run/current-system/sw/bin"

        open_mode=suggested
        save_mode=last
      '';
    };
  };
}
