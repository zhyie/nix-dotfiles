{
  description = "zhyie's Nix Flake Configuration";

  ########## INPUTS ##########
  inputs = {
    # NIX PACKAGES FOR NIXOS
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    # MODULES FOR HARDWARE QUIRKS
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # HOME MANAGER FOR NIX
    home-manager = { url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # SECRET MANAGEMENT
    sops-nix = { url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # CATPUCCIN THEMES
    catppuccin.url = "github:catppuccin/nix/release-25.11";

    # PERSONAL REPO
    suckless.url = "github:zrhive/suckless";
  };

  ########## OUTPUTS ##########
  outputs = { self, nixpkgs, ... } @ inputs: let
    inherit (nixpkgs) lib;
    #inherit (lib) mapAttrs mapAttrs' nameValuePair;

    # List of hosts and their specifications
    hosts = import ./hosts { inherit inputs; };
    users = import ./users { inherit inputs; };
    # Nixos and home modules
    nixos = import ./modules/nixos;
    home = import ./modules/home;
    dots = import ./dotfiles;
    scripts = import ./scripts;

    # Get the systems within hosts attrs, lib.unique to prevent duplicates
    # systems = lib.unique (lib.attrValues (lib.mapAttrs (_: cfg: cfg.system) hosts));
    systems = lib.attrValues (lib.mapAttrs (_: cfg: cfg.system) hosts);
    forAllSystems = lib.genAttrs systems;

    # set of args to pass in
    xargs = { inherit self inputs lib hosts users nixos home dots scripts; };
    # function to build hosts
    xlib = import ./lib xargs;
  in
  {
    # Formatter for nix files
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    # Custom packages
    # packages = forAllSystems (system: import ./packages nixpkgs.legacyPackages.${system});
    # Nixpkgs overlays
    overlays = import ./overlays { inherit inputs; };
    # devShell = forAllSystem (system: ${system}.default = import ./shell.nix { inherit pkgs; });

    # GENERATE HOSTS|HOMES CONFIGURATION
    nixosConfigurations = lib.mapAttrs xlib.mkHost hosts;
    # darwinConfigurations = lib.mapAttrs mkHost hosts;
    # homeConfigurations = lib.mapAttrs' xlib.mkHome hosts;
  };
}
