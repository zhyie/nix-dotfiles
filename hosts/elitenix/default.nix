{ inputs, nixos, ... }:
{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.hp-elitebook-830g6
    (inputs.nixos-hardware + "/common/gpu/intel/whiskey-lake")
    (import inputs.suckless)
    nixos.common
    nixos.hardware
    nixos.security
    nixos.services
    nixos.themes.catppuccin
    nixos.themes.nmtui
    nixos.xserver
  ];
}
