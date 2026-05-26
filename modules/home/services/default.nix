rec {
  notification = import ./notification;
  inherit (notification) dunst mako;

  screen-capture = import ./screen-capture;
  inherit (screen-capture) flameshot;

  picom = import ./picom.nix;
  udiskie = import ./udiskie.nix;
}
