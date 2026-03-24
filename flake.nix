{
  description = "zhyie's Nix Flake Configuration";

  inputs = {
    self.submodules = true;
    ## NIXPKGS
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    ## HARDWARE MODULES
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    ## HOME MANAGER
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ## SECRET MANAGEMENT
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ## CATPUCCIN THEMES
    catppuccin.url = "github:catppuccin/nix/release-25.11";
    ## PERSONAL REPO
    suckless = {
      url = "path:/home/zhyie/.suckless";
      flake = false;
    };
    dotfiles = {
      url = "path:./dotfiles";
      flake = false;
    };
    secrets = {
      url = "path:./.secrets";
      flake = false;
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      # Hosts and their specifications
      hosts = import ./hosts;
      users = import ./users;
      # Nixos and home modules
      nixos = self.nixosModules;
      home = self.homeManagerModules;
      # set of args to pass in
      args = {
        inherit
          self
          inputs
          hosts
          users
          nixos
          home
          ;
      };

      lib = nixpkgs.lib // import ./lib args;
      # systems = lib.systems.flakeExposed;
      # Get the systems within hosts attrs, lib.unique to prevent duplicates
      # systems = lib.unique (lib.attrValues (lib.mapAttrs (_: h: h.system) hosts));
      systems = lib.attrValues (lib.mapAttrs (_: cfg: cfg.system) hosts);
      eachSystem = lib.genAttrs systems;
      # eachSystem = f: lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system} // { inherit inputs system; });
    in
    {
      formatter = eachSystem (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
      overlays = import ./overlays { inherit inputs; };
      packages = eachSystem (system: import ./packages nixpkgs.legacyPackages.${system} inputs);
      # devShell = eachSystem (system: import ./shell.nix nixpkgs.legacyPackages.${system});

      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home;

      # GENERATE HOSTS|HOMES CONFIGURATION
      nixosConfigurations = lib.mapAttrs lib.mkHost hosts;
      # darwinConfigurations = lib.mapAttrs _lib.mkHost hosts;
      # homeConfigurations = lib.mapAttrs' _lib.mkHome hosts;
    };
}
