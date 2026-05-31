rec {
  #: Audio
  audio = ./audio;
  inherit (audio) pipewire;

  #: Bluetooth
  bluetooth = ./bluetooth;

  #: Backlight
  backlight = ./backlight;
  inherit (backlight) light;

  #: Input
  input = ./input;
  inherit (input) mouse touchpad trackpoint;

  #: Power
  power = ./power;

  #: Printing
  printing = ./printing;
}
