# { ... }:
# let
#   inherit (inputs) nixos-hardware sops-nix;
#   hardware = nixos-hardware.nixosModules;
# in
{
  elitenix = {
    imports = [ ./elitenix ];
    userList = [ "zhyie" ];
    # moduleList = [
    #   ./elitenix
    #   hardware.hp-elitebook-830g6
    #   hardware.common-gpu-intel
    #   sops-nix.nixosModules.sops
    #   # suckless.nixosModules.default
    #   (import inputs.suckless)
    # ];
    system = "x86_64-linux";
    stateVersion = "25.11";
  };
}
