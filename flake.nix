{
  description = "Zhyie's Nix Flake Configuration";

  #################### INPUTS ####################
  inputs = {
    # NIX PACKAGES FOR NIXOS
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    # MODULES FOR HARDWARE QUIRKS
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # HOME MANAGER FOR NIX
    home-manager = { url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs"; };

    # SECRET MANAGEMENT
    sops-nix = { url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs"; };

    # CATPUCCIN THEMES
    catppuccin.url = "github:catppuccin/nix/release-25.11";
  };

  #################### OUTPUTS ####################
  outputs = { self, nixpkgs, ... } @ inputs:
  let
    inherit (nixpkgs) lib;
    #inherit (lib) mapAttrs mapAttrs' nameValuePair;

    # List of hosts and their specifications
    hosts = import ./hosts { inherit inputs; };
    users = import ./users;
    # Nixos and home modules
    modules = import ./modules;
    home = import ./home;

    # extra modules to be added for host created
    xmodules = with inputs; [
      sops-nix.nixosModules.sops
      catppuccin.nixosModules.catppuccin
    ];
    # set of inherits to pass in
    xinherits = { inherit inputs lib xmodules hosts users modules home; };
    # Helper functions to build hosts and for clean structure
    xlib = import ./lib (xinherits);

    # Get the systems within hosts attrs, lib.unique to prevent duplicates
    systems = lib.unique (lib.attrValues (lib.mapAttrs (_: cfg: cfg.system) hosts));
    forAllSystems = lib.genAttrs systems;
  in {
    # Custom packages
    # packages = forAllSystems (system: import ./packages nixpkgs.legacyPackages.${system});
    # Formatter for nix files
    # formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    # Nixpkgs overlays
    overlays = import ./overlays { inherit inputs; };

    # devShell = forAllSystem (system: ${system}.default = import ./shell.nix { inherit pkgs; });

    # HOSTS|HOME|SYSTEM CONFIGURATION GENERATION
    nixosConfigurations = lib.mapAttrs xlib.mkHost hosts;
    # darwinConfigurations = lib.mapAttrs xlib.mkHost hosts;
    # homeConfigurations = mapAttrs' (n: v: nameValuePair (
    #   genAttrs' v.userList ()
    # ) (xlib.mkHome)) hosts;
  };
}
