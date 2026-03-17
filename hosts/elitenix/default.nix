{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.hp-elitebook-830g6
    (inputs.nixos-hardware + "/common/gpu/intel/whiskey-lake")
    (import inputs.suckless)
    ./configuration.nix
    ./hardware-configuration.nix
    ./laptop.nix
    ./environment.nix
  ];
}
