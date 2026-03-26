rec {
  pipewire = import ./pipewire.nix;

  imports = [
    pipewire
  ];
}
