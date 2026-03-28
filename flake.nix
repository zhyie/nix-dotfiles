{
  description = "zhyie's Nix Flake Configuration";

  inputs = {
    self.submodules = true;

    ## NIXPKGS --------------------------------------------------
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    ## HARDWARE MODULES -----------------------------------------
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    ## HOME MANAGER ---------------------------------------------
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ## SECRET MANAGEMENT ----------------------------------------
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    ## CATPUCCIN THEMES -----------------------------------------
    catppuccin.url = "github:catppuccin/nix/release-25.11";

    ## PERSONAL REPO --------------------------------------------
    suckless.url = "path:/home/zhyie/.suckless";
    dotfiles.url = "path:./dotfiles";
    secrets.url = "path:./.secrets";
    suckless.flake = false;
    dotfiles.flake = false;
    secrets.flake = false;
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      ## Hosts and their specifications
      hosts = import ./hosts;
      users = import ./users;
      ## Nixos and home modules
      nixos = self.nixosModules;
      home = self.homeModules;
      ## Set of args to pass in
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

      # lib = nixpkgs.lib // import ./lib args;
      lib = import ./lib args;
      inherit (lib) mkHost;
      inherit (nixpkgs.lib)
        mapAttrs
        genAttrs
        attrValues
        unique
        # mkHost
        ;
      # systems = lib.systems.flakeExposed;

      ## Get the systems within hosts attrs, lib.unique to prevent duplicates
      systems = unique (attrValues (mapAttrs (_: h: h.system) hosts));
      # systems = lib.attrValues (lib.mapAttrs (_: cfg: cfg.system) hosts);
      # eachSystem = genAttrs systems;
      # eachSystem = f: genAttrs systems (system: f {
      #   inherit system inputs;
      #   pkgs = nixpkgs.legacyPackages.${system};
      # });
      eachSystem = f: genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      overlays = import ./overlays { inherit inputs; };
      formatter = eachSystem (pkgs: pkgs.nixfmt-tree);
      packages = eachSystem (pkgs: import ./packages { inherit pkgs inputs; });
      devShells = eachSystem (pkgs: import ./shell.nix { inherit pkgs; });

      ## EXPORTING MODULES
      nixosModules = import ./modules/nixos;
      homeModules = import ./modules/home;

      ## GENERATE HOSTS|HOMES CONFIGURATION
      nixosConfigurations = mapAttrs mkHost hosts;
      # darwinConfigurations = mapAttrs mkHost hosts;
      # homeConfigurations = listToAttrs mkHome (attrValues (mapAttrs(_: u: u.hostList) users));
    };
}
