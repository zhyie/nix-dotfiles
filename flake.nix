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
    #: DEVELOPMENT ----------------------------------------------
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    direnv-instant = {
      url = "github:Mic92/direnv-instant";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.treefmt-nix.follows = "treefmt-nix";
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
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
    #: THEMES ---------------------------------------------------
    catppuccin = {
      url = "github:catppuccin/nix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #: FLATPAK
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    #: PERSONAL REPO --------------------------------------------
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
      args = {
        inherit
          inputs
          hosts
          users
          modules
          ;
      };

      lib = import ./lib args // inputs.nixpkgs.lib // inputs.home-manager.lib;
      inherit (lib)
        mapAttrs
        listToAttrs
        mkNixos
        mkHome
        eachSystem
        ;

      treefmtEval = eachSystem (pkgs: inputs.treefmt-nix.lib.evalModule pkgs ./checks/treefmt.nix);
    in
    {
      inherit lib modules;

      #: GENERATE HOSTS|HOMES CONFIGURATION
      nixosConfigurations = mapAttrs mkNixos hosts;
      # darwinConfigurations = mapAttrs mkDarwin hosts;
      homeConfigurations = listToAttrs (mkHome hosts);

      #: EXPORT MODULES
      nixosModules = modules.nixos;
      homeModules = modules.home;

      overlays = import ./overlays { inherit inputs; };
      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
      packages = eachSystem (pkgs: import ./packages { inherit pkgs inputs; });
      devShells = eachSystem (pkgs: import ./shell.nix { inherit pkgs; });

      checks = eachSystem (
        pkgs:
        {
          formatting = treefmtEval.${pkgs.stdenv.hostPlatform.system}.config.build.check inputs.self;
          # nixosEval =
          #   let
          #     system = lib.filterAttrs (_: c: c.pkgs.system == pkgs.system) inputs.self.nixosConfigurations;
          #   in
          #   mapAttrs (_: c: c.config.system.build.toplevel) system;
          # nixosEval = mapAttrs (
          #   host: _: inputs.self.nixosConfigurations.${host}.config.system.build.toplevel
          # ) hosts;
        }
        // mapAttrs (host: _: inputs.self.nixosConfigurations.${host}.config.system.build.toplevel) hosts
      );
    };
}
