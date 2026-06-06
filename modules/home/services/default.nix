rec {
  flatpak = ./flatpak.nix;

  notification = import ./notification;
  inherit (notification) dunst mako;

  screen-capture = import ./screen-capture;
  inherit (screen-capture) flameshot;

  picom = ./picom.nix;
  udiskie = ./udiskie.nix;
}
