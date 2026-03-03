{ inputs, ... }:

let
  inherit (inputs) nixos-hardware;
in

{
  elitenix = {
    system = "x86_64-linux";
    userList = [ "zhyie" ];
    moduleList = [
      ./elitenix
      nixos-hardware.nixosModules.hp-elitebook-830g6
      nixos-hardware.nixosModules.common-gpu-intel
    ];
    stateVersion = "25.11";
  };
  # asunix = {
  #   system = "xi686-linux";
  #   userList = [ "absky" ];
  #   moduleList = [];
  #   stateVersion = "";
  # };
  # samnix = {
  #   system = "x86_64-linux";
  #   userList = [ "absky" ];
  #   moduleList = [];
  # };
}
