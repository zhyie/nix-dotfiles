rec {
  inputs = import ./inputs;

  imports = [
    inputs
    ./audio
    ./bluetooth
    ./power
    ./printing
  ];

  inherit (inputs)
    mouse
    touchpad
    trackpoint
    ;
}
