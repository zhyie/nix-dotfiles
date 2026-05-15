{ inputs, nixos, ... }:
{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.hp-elitebook-830g6
    # inputs.nixos-hardware.nixosModules.common-gpu-intel
    (inputs.nixos-hardware + "/common/gpu/intel/whiskey-lake")
    inputs.suckless.nixosModules.suckless
    nixos.hardware
    nixos.xserver
    nixos.themes.console
    nixos.themes.nmtui
  ]
  ++ nixos.services.default;
}
