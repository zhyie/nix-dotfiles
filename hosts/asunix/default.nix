{ modulesPath, nixos, ... }:
{
  imports = [
    #: Host configuration
    ./configuration.nix

    (modulesPath + "/installer/cd-dvd/iso-image.nix")
    (modulesPath + "/profiles/all-hardware.nix")
    (modulesPath + "/profiles/base.nix")

    nixos.profiles.graphical
  ];
}
