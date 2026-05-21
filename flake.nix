{
  description = "zhyie's Nix Flake Configuration";

  inputs = {
    self.submodules = true;
    #: NIXPKGS --------------------------------------------------
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    #: HARDWARE MODULES -----------------------------------------
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    #: HOME MANAGER ---------------------------------------------
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #: SECURITY -------------------------------------------------
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # lanzaboote = {
    #   url = "github:nix-community/lanzaboote/v1.0.0";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
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
      #: HOSTS AND THEIR SPECIFICATIONS
      hosts = import ./hosts;
      users = import ./users;
      modules = import ./modules;
      #: SET OF ARGS TO PASS IN
      args = { inherit inputs hosts users; };

      #: libs
      lib' = import ./lib args;
      lib = lib' // inputs.nixpkgs.lib // inputs.home-manager.lib;
      inherit (lib)
        mapAttrs
        listToAttrs
        mkNixos
        mkHome
        eachSystem
        ;
    in
    {
      inherit lib lib' modules;

      #: GENERATE HOSTS|HOMES CONFIGURATION
      nixosConfigurations = mapAttrs mkNixos hosts;
      # darwinConfigurations = mapAttrs mkDarwin hosts;
      homeConfigurations = listToAttrs (mkHome hosts);

      #: EXPORT MODULES
      nixosModules = modules.nixos;
      homeModules = modules.home;

      #: PACKAGES AND OVERLAYS
      overlays = import ./overlays { inherit inputs; };
      packages = eachSystem (pkgs: import ./packages { inherit pkgs inputs; });

      #: CUSTOM TREEFMT FORMATTER
      formatter = eachSystem (pkgs: pkgs.callPackage ./checks/formatter.nix { inherit inputs; });

      #: SHELL ENVIRONMENT
      devShells = eachSystem (pkgs: import ./shell.nix { inherit pkgs; });

      #: CHECKS
      checks = eachSystem (pkgs: import ./checks { inherit inputs pkgs; });
    };
}
