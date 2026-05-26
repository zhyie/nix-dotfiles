{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.yazi = {
    enable = true;
    package = pkgs.unstable.yazi.override { _7zz = pkgs._7zz-rar; };
    shellWrapperName = "y";
    enableBashIntegration = true;
    enableNushellIntegration = config.programs.nushell.enable;
    extraPackages =
      builtins.attrValues {
        inherit (pkgs)
          ueberzugpp
          glow
          ouch
          lazygit
          mediainfo
          trash-cli
          ;
      }
      ++ lib.optionals config.modules.xserver.enable [ pkgs.xclip ]
      ++ lib.optionals config.modules.wayland.enable [ pkgs.wl-clipboard ];
  };
}
