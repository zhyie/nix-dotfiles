{ inputs, system, lib, pkgs, ... }:

let

  hostname = "elitenix";
  username = "zhyie";
  
  # NixOS hardware quirks
  nixos-hardware = inputs.nixos-hardware.nixosModules.hp-elitebook-830g6;
  home-manager = inputs.home-manager.nixosModules;

in lib.nixosSystem {

  inherit system;

  specialArgs = { inherit hostname; };

  modules = [
    # NixOS configuration
    ./configuration.nix

    # Hardware quirks
    nixos-hardware

    # Home manager as module to NixOS
    home-manager.home-manager {
      home-manager = {

        useGlobalPkgs = true;
	useUserPackages = true;
	extraSpecialArgs = { inherit username; };
	backupFileExtension = "backup";
	users.${username} = ../../home/users/${username};
      };

    }
  ];

}
