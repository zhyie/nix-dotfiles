{ inputs, ... }:

let
  inherit (inputs) nixos-hardware sops-nix suckless;
  hardware = nixos-hardware.nixosModules;
in

{
  elitenix = {
    system = "x86_64-linux";
    userList = [ "zhyie" ];
    moduleList = [
      ./elitenix
      hardware.hp-elitebook-830g6
      hardware.common-gpu-intel
      sops-nix.nixosModules.sops
      suckless.nixosModules.default
    ];
    stateVersion = "25.11";
  };

  # asunix = {
  #   system = "xi686-linux";
  #   userList = [ "absky" ];
  #   moduleList = [];
  #   stateVersion = "";
  # };
  #
  # samnix = {
  #   system = "x86_64-linux";
  #   userList = [ "absky" ];
  #   moduleList = [];
  # };
}
