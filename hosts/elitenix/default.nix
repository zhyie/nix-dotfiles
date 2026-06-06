{ inputs, nixos, ... }:
{
  imports = [
    #: Host configuration
    ./configuration.nix
    ./hardware-configuration.nix

    #: Extra hardware modules
    inputs.nixos-hardware.nixosModules.hp-elitebook-830g6
    (inputs.nixos-hardware + "/common/gpu/intel/whiskey-lake")

    #: DWM + suckless tools
    # inputs.suckless.nixosModules.default

    #: Pre-configured modules
    nixos.profiles.laptop
    nixos.profiles.graphical
    nixos.profiles.gaming
    nixos.themes.console
    nixos.themes.nmtui
  ];
}
