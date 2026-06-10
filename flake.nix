{
  description = "zhyie's Nix Flake Configuration";

  inputs = {
    #: NIXOS AND NIXPKGS ----------------------------------------
    nixpkgs.follows = "nixos-stable";
    nixpkgs-droid.url = "github:NixOS/nixpkgs/88d3861";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-stable.url = "github:NixOS/nixpkgs/nixos-26.05";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs-droid";
      inputs.home-manager.follows = "home-manager-droid";
      inputs.nix-formatter-pack.inputs.nmd.follows = "nix-on-droid/nmd";
    };

    #: HOME MANAGER ---------------------------------------------
    home-manager.follows = "home-manager-release";
    home-manager-droid = {
      follows = "home-manager-master";
      inputs.nixpkgs.follows = "nixpkgs-droid";
    };
    home-manager-master = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-release = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #: MISC -----------------------------------------------------
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    #: ZHYIE's --------------------------------------------------
    secrets = {
      url = "git+ssh://git@gitlab.com/zrhive/nix-secrets.git?ref=main&shallow=1";
      flake = false;
    };
    dotfiles = {
      url = "github:zrhive/dotfiles/main";
      flake = false;
    };
    suckless = {
      url = "gitlab:zrhive/suckless/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, ... }@inputs:
    let
      inherit (inputs.nixpkgs.lib) mapAttrs listToAttrs;

      #: HOSTS AND THEIR SPECIFICATIONS
      hosts = import ./hosts;
      users = import ./users;
      modules = import ./modules;
    in
    rec {
      #: FUNCTION LIBRARY
      lib = import ./lib {
        inherit
          inputs
          hosts
          users
          modules
          ;
      };

      #: GENERATE HOSTS|HOMES CONFIGURATION
      nixosConfigurations = mapAttrs lib.mkNixos (lib.filterNixos hosts);
      nixOnDroidConfigurations = mapAttrs lib.mkDroid (lib.filterDroid hosts);
      homeConfigurations = listToAttrs (lib.mkHome hosts);

      #: EXPORT MODULES
      nixosModules = import ./modules/nixos;
      homeModules = import ./modules/home;

      #: PACKAGES AND OVERLAYS
      overlays = import ./overlays { inherit inputs; };
      packages = lib.eachSystem (pkgs: import ./packages { inherit pkgs inputs; });

      #: FORMATTER
      formatter = lib.eachSystem (pkgs: packages.${pkgs.stdenv.hostPlatform.system}.treefmt);

      #: CHECKS
      checks = lib.eachSystem (
        pkgs:
        mapAttrs (h: _: nixosConfigurations.${h}.config.system.build.toplevel) nixosConfigurations
        // mapAttrs (h: _: homeConfigurations.${h}.activationPackage) homeConfigurations
        // {
          git-hooks = inputs.git-hooks.lib.${pkgs.stdenv.hostPlatform.system}.run {
            src = ./.;
            package = pkgs.prek;

            excludes = [
              "^(dotfiles|secrets)/.*"
              "^hosts/.*/hardware-configuration.nix$"
            ];

            hooks.nix-fmt = {
              enable = true;
              description = "Nix Treefmt";
              entry = "nix fmt";
              files = "\\.nix$";
            };
          };
        }
      );

      #: SHELL ENVIRONMENT
      devShells = lib.eachSystem (pkgs: {
        default = pkgs.mkShellNoCC {
          inherit (checks.${pkgs.stdenv.hostPlatform.system}.git-hooks) shellHook;

          packages = [
            self.packages.${pkgs.stdenv.hostPlatform.system}.hm
            pkgs.nixd
            pkgs.nixfmt
            pkgs.statix
            pkgs.deadnix

            pkgs.bat
            pkgs.lazygit
          ];
        };
      });
    };
}
