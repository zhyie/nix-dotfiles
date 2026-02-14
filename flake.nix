{
  description = "Zhyie's NixOs Flake Configuration";


  #################### INPUTS ####################

  inputs = {

    # Nix packages for NixOS
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    # NixOS modules for hardware quirks
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home manager for Nix
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Catppuccin
    catppuccin.url = "github:catppuccin/nix/release-25.11";

  };


  #################### OUTPUTS ####################

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... } @ inputs:

    let

      # System used
      system = "x86_64-linux";

      # system = { "", "", "" };
      # hosts = { hostname = "elitenix"; hostname = "samnix"; };

      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};

      #extraModules = [  ];


    in {

      nixosConfigurations = {

	    # NixOS on for elitebook
	    elitenix = import ./hosts/elitenix { inherit inputs system lib pkgs; };

      };

    };
}
