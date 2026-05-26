{ config, lib, ... }:

let
  inherit (lib) mkDefault optional elem;
  inherit (config.modules.flatpak) appList;

  #: appIDs
  libreoffice = "org.libreoffice.LibreOffice";
  sober = mkDefault "org.vinegarhq.Sober";
  mcpe = mkDefault "io.mrarm.mcpelauncher";
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
    libreoffice.id = mkDefault libreoffice;
    libreOffice.id = mkDefault "org.libreoffice.LibreOffice";

    sober.id = mkDefault "org.vinegarhq.Sober";
    roblox.id = mkDefault "org.vinegarhq.Sober";

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
