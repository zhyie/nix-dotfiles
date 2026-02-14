# suckless.org - software that sucks less
# https://suckless.org/
#
# slstatus: https://tools.suckless.org/dmenu/
# dmenu: https://tools.suckless.org/slstatus/
# st: https://st.suckless.org/

{ pkgs, ... }:

let

  slstatus = pkgs.slstatus.overrideAttrs { src = ../../config/suckless/slstatus; };
  dmenu = pkgs.dmenu.overrideAttrs { src = ../../config/suckless/dmenu; };
  st = pkgs.st.overrideAttrs { src = ../../config/suckless/st; };

in {

  environment.systemPackages = [
    slstatus
    dmenu
    st
  ];
}
