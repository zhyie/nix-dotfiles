rec {
  mouse = import ./mouse.nix;
  touchpad = import ./touchpad.nix;
  trackpoint = import ./trackpoint.nix;

  imports = [
    mouse
    touchpad
    trackpoint
  ];
}
