# ############################################
# suckless.org
# --------------------------------------------
# software that sucks less
# https://suckless.org/
# --------------------------------------------
# dwm: https://dwm.suckless.org/
# slstatus: https://tools.suckless.org/dmenu/
# dmenu: https://tools.suckless.org/slstatus/
# st: https://st.suckless.org/
# ############################################

{ config, pkgs, ... }:

let

  dwm = pkgs.dwm.overrideAttrs { src = ./dwm; };
  slstatus = pkgs.slstatus.overrideAttrs { src = ./slstatus; };
  dmenu = pkgs.dmenu.overrideAttrs { src = ./dmenu; };
  st = pkgs.st.overrideAttrs { src = ./st; };

  status = config.services.slstatus;

in {
  services.xserver.windowManager.dwm = {
    enable = true;
    package = dwm;
  };

  environment.systemPackages = [
    slstatus
    dmenu
    st
  ];

  systemd.user.services.slstatus = {
    enable = true;
    description = "Status service for DWM";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${status.slstatus}/bin/slstatus &";
    };
  };
}
