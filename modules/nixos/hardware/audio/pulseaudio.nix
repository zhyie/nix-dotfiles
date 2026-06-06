{ lib, ... }:
{
  # Set PipeWire to false to use PulseAudio.
  services.pipewire.enable = lib.mkDefault false;

  services.pulseaudio = {
    enable = lib.mkDefault true;
    support32Bit = lib.mkDefault true;
  };
}
