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
    # nixos-2405.url = "github:NixOS/nixpkgs/nixos-24.05";
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
    # home-manager-2405 = {
    #   url = "github:nix-community/home-manager/release-24.05";
    #   inputs.nixpkgs.follows = "nixos-2405";
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
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
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
      url = "github:zrhive/dotfiles/main";
      flake = false;
    };
    suckless = {
      url = "github:zrhive/suckless/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, ... }@inputs:
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
      lib' = import ./lib args;
      inherit (lib')
        eachSystem
        mkHost
        mkDroid
        mkHome
        filterNixos
        filterDroid
        ;
    in
    {
      inherit lib' modules;

      #: GENERATE HOSTS|HOMES CONFIGURATION
      nixosConfigurations = mapAttrs mkHost (filterNixos hosts);
      nixOnDroidConfigurations = mapAttrs mkDroid (filterDroid hosts);
      # darwinConfigurations = mapAttrs mkDarwin hosts;
      homeConfigurations = listToAttrs (mkHome hosts);

      #: EXPORT MODULES
      nixosModules = modules.nixos;
      homeModules = modules.home;

      #: PACKAGES AND OVERLAYS
      overlays = import ./overlays { inherit inputs; };
      packages = eachSystem (pkgs: import ./packages { inherit pkgs inputs; });

      #: FORMATTER
      formatter = eachSystem (
        pkgs:
        pkgs.writeShellScriptBin "git-hooks" ''
          ${pkgs.lib.getExe pkgs.pre-commit} run --all-files
        ''
      );

      #: CHECKS
      checks = eachSystem (
        pkgs:
        mapAttrs (h: _: self.nixosConfigurations.${h}.config.system.build.toplevel) self.nixosConfigurations
        // mapAttrs (h: _: self.homeConfigurations.${h}.activationPackage) self.homeConfigurations
        // {
          git-hooks = inputs.git-hooks.lib.${pkgs.stdenv.hostPlatform.system}.run {
            src = ./.;
            package = pkgs.prek;
            excludes = [
              "^hosts/.*/hardware-configuration.nix$"
              "^dotfiles/.*"
              "^secrets/.*"
            ];
            hooks = {
              nixfmt.enable = true;
              deadnix = {
                enable = true;
                settings = {
                  edit = true;
                  noLambdaPatternNames = true;
                };
              };
              statix = {
                enable = true;
                entry = "${pkgs.statix}/bin/statix fix -c ${pkgs.writeText "statix.toml" ''
                  disabled = [
                    "manual_inherit_from",
                    "empty_pattern",
                    "redundant_pattern_bind",
                    "repeated_keys",
                  ]
                ''}";
              };
            };
          };
        }
      );

      #: SHELL ENVIRONMENT
      devShells = eachSystem (pkgs: {
        default =
          let
            inherit (self.checks.${pkgs.stdenv.hostPlatform.system}.git-hooks)
              shellHook
              enabledPackages
              ;
          in
          pkgs.mkShellNoCC {
            inherit shellHook;
            buildInputs = enabledPackages;

            packages = [
              pkgs.home-manager
              pkgs.nh

              pkgs.macchina
              pkgs.bat
              pkgs.statix
              pkgs.prek
            ];
          };
      });
    };
}
