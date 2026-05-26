rec {
  #: Audio
  audio = import ./audio;
  inherit (audio) pipewire;

  #: Bluetooth
  bluetooth = import ./bluetooth;

  #: Backlight
  backlight = import ./backlight;
  inherit (backlight) light;

  #: Input
  input = import ./input;
  inherit (input) mouse touchpad trackpoint;

  #: Power
  power = import ./power;

  #: Printing
  printing = import ./printing;
}
