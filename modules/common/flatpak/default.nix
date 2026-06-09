{ config, lib, ... }:

let
  inherit (lib) optional elem;
  inherit (config.modules.flatpak) appList;

  #: appIDs
  libreoffice = "org.libreoffice.LibreOffice";
  sober = "org.vinegarhq.Sober";
  mcpe = "io.mrarm.mcpelauncher";
in
{
  imports = [ ./options.nix ];

  modules.flatpak.apps = {
    /**
      ----------------------------
      List of pre-configured apps
      ----------------------------
      Current available options:

      <app> = {
        enable = <true or false>;
        id = "<appID>";
      };
      ----------------------------
      where:
        `enable`  enable the app
        `id`      app ID
      ----------------------------
    */
    libreoffice.id = libreoffice;
    libreOffice.id = "org.libreoffice.LibreOffice";

    sober.id = "org.vinegarhq.Sober";
    roblox.id = "org.vinegarhq.Sober";

    mcpe.id = mcpe;
  };

  /**
    ALTERNATIVE METHOD: LISTING NAMES
      appList = [ "libreoffice" "sober" ]
  */
  services.flatpak.packages =
    optional (elem "libreoffice" appList) libreoffice
    ++ optional (elem "libreOffice" appList) libreoffice
    ++ optional (elem "sober" appList) sober
    ++ optional (elem "roblox" appList) sober
    ++ optional (elem "mcpe" appList) mcpe;
}
