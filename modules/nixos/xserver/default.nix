{
  default = import ./xserver.nix;
  xautolock = import ./xautolock.nix;
  xscreensaver = import ./xscreensaver.nix;

  dwm = import ./dwm.nix;
}
