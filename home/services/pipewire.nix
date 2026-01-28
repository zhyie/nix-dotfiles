{ config, pkgs, ... }:

{

  # Set PulseAudio to false to use PipeWire.
  services.pulseaudio.enable = false;

  # Optional but recommended.
  # Allows PipeWire to use realtime scheduler
  # for increased performance.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
  };

}
