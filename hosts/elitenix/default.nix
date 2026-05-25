{ inputs, nixos, ... }:
{
  imports = [
    #: Host configuration
    ./configuration.nix
    ./hardware-configuration.nix

    #: Extra hardware modules
    inputs.nixos-hardware.nixosModules.hp-elitebook-830g6
    "${inputs.nixos-hardware}/common/gpu/intel/whiskey-lake"

    #: DWM + suckless tools
    inputs.suckless.nixosModules.suckless

    #: Pre-configured modules
    nixos.themes.console
    nixos.themes.nmtui
  ];
}
