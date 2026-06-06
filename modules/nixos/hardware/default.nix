rec {
  #: Audio
  audio = import ./audio;
  inherit (audio) pipewire pulseaudio;

  #: Bluetooth
  bluetooth = import ./bluetooth;
  inherit (bluetooth) blueman;

  #: Backlight
  backlight = import ./backlight;
  inherit (backlight) brightnessctl light;

  #: Input
  input = import ./input;
  inherit (input) mouse touchpad trackpoint;

  #: Printing
  printing = import ./printing;
  inherit (printing) brother;
}
