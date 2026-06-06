{ nixos, ... }:
{
  imports = [
    ./bluetooth.nix
    nixos.services.avahi
  ];

  # Graphical interface for managing bluetooth
  services.blueman.enable = true;
}
