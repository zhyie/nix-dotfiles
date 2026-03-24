{ inputs, nixos, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.hp-elitebook-830g6
    (inputs.nixos-hardware + "/common/gpu/intel/whiskey-lake")
    (import inputs.suckless)
    nixos.common
    nixos.security
    nixos.services
    nixos.themes.catppuccin
    nixos.themes.nmtui
    ./configuration.nix
    ./hardware-configuration.nix
    ./laptop.nix
  ];
}
