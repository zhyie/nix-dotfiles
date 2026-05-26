{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.flatpak = {
    enable = lib.mkEnableOption "Enable flatpak modules.";

    packages = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = lib.literalExpression ''
        [ "org.libreoffice.LibreOffice" "org.vinegarhq.Sober" ]
      '';
      description = ''
        Compile all enabled the flatpak packages,
        plus the added custom packages by the users.
        Accepts appID only, to declare other than appID,
        use `services.flatpak.packages = [ { ... } ]`
      '';
    };

    #: Easy method to install flatpaks, by <appName>.enable = true;
    apps = lib.mkOption {
      type = lib.types.attrsOf (
        lib.types.submodule (
          { name, ... }:
          {
            options = {
              enable = lib.mkEnableOption "Install ${name}.";
              id = lib.mkOption {
                type = lib.types.str;
                default = "";
                example = lib.literalExpression ''
                  id = "org.libreoffice.LibreOffice";
                '';
                description = "Application ID.";
              };
            };
          }
        )
      );
      default = { };
      example = lib.literalExpression ''
        apps.libreoffice = {
          enable = true;
          id = "org.libreoffice.LibreOffice";
        };
      '';
      description = "Flatpaks to enable and install.";
    };

    #: Alternative method for user to declare flatpaks
    appList = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = lib.literalExpression ''
        appList = [ "libreoffice" "sober" ]
      '';
      description = ''
        Alternative method to install packages.
        List of flatpak names instead of by appID.
      '';
    };
  };

  /**
    IMPLEMENTATION
  */
  config =
    lib.mkIf
      (
        config.modules.flatpak.enable
        || config.modules.flatpak.appList != [ ]
        || lib.any (app: app.enable) (lib.attrValues config.modules.flatpak.apps)
      )
      {
        #: Compile flatpak packages
        modules.flatpak.packages = lib.concatMap (app: lib.optional app.enable app.id) (
          lib.attrValues config.modules.flatpak.apps
        );

        #: FLATPAK
        services.flatpak = {
          enable = true;
          remotes = [
            {
              name = "flathub";
              location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
            }
          ];
          update.onActivation = true;

          packages = config.modules.flatpak.packages;
        };

        #: portal frontend service for Flatpak
        xdg.portal = {
          enable = true;
          extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
          config.common.default = "*";
        };
      };
}
