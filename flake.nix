{
  description = "zhyie's Nix Flake Configuration";

  inputs = {
    self.submodules = true;

    #: NIXOS AND NIXPKGS ----------------------------------------
    nixpkgs.follows = "nixos-stable";
    nixpkgs-droid.follows = "nixpkgs";
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    # nixos-24-05.url = "github:NixOS/nixpkgs/nixos-24.05";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-droid";
      inputs.home-manager.follows = "home-manager-droid";
    };

    #: HOME MANAGER ---------------------------------------------
    home-manager.follows = "home-manager-stable";
    home-manager-droid.follows = "home-manager";
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # home-manager-24-05 = {
    #   url = "github:nix-community/home-manager/release-24.05";
    #   inputs.nixpkgs.follows = "nixpkgs-24-05";
    # };

    #: HARDWARE AND SECURITY ------------------------------------
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # lanzaboote = {
    #   url = "github:nix-community/lanzaboote/v1.0.0";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #: DEVELOPMENT ----------------------------------------------
    direnv-instant = {
      url = "github:Mic92/direnv-instant";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #: MISC -----------------------------------------------------
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    catppuccin = {
      url = "github:catppuccin/nix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #: ZHYIE's --------------------------------------------------
    secrets = {
      url = "git+ssh://git@github.com/zhyie/nix-secrets.git?ref=main&shallow=1";
      flake = false;
    };
    dotfiles = {
      url = "path:./dotfiles";
      flake = false;
    };
    suckless = {
      url = "github:zrhive/suckless/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { ... }@inputs:
    let
      lib = inputs.nixpkgs.lib // inputs.home-manager.lib // inputs.nix-on-droid.lib;
      inherit (lib) mapAttrs listToAttrs;

      #: HOSTS AND THEIR SPECIFICATIONS
      hosts = import ./hosts;
      users = import ./users;
      modules = import ./modules;
      #: SET OF ARGS TO PASS IN
      args = {
        inherit
          inputs
          lib
          hosts
          users
          ;
      };

      #: Function library
      fn = import ./lib args;
      inherit (fn)
        eachSystem
        mkNixos
        mkDroid
        mkHome
        ;
    in
    {
      inherit fn modules;

      #: GENERATE HOSTS|HOMES CONFIGURATION
      nixosConfigurations = mapAttrs mkNixos hosts;
      nixOnDroidConfigurations = mapAttrs mkDroid hosts;
      # darwinConfigurations = mapAttrs mkDarwin hosts;
      homeConfigurations = listToAttrs (mkHome hosts);

      #: EXPORT MODULES
      nixosModules = modules.nixos;
      homeModules = modules.home;

      #: PACKAGES AND OVERLAYS
      overlays = import ./overlays { inherit inputs; };
      packages = eachSystem (pkgs: import ./packages { inherit pkgs inputs; });

      #: CUSTOM TREEFMT FORMATTER
      formatter = eachSystem (pkgs: import ./checks/treefmt.nix { inherit pkgs; });

      #: SHELL ENVIRONMENT
      devShells = eachSystem (pkgs: import ./shell.nix { inherit pkgs; });

      #: CHECKS
      checks = eachSystem (pkgs: import ./checks { inherit inputs pkgs; });
    };
}
