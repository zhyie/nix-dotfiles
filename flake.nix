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
    ## DEVELOPMENT ----------------------------------------------
    direnv-instant.url = "github:Mic92/direnv-instant";
    direnv-instant.inputs.nixpkgs.follows = "nixpkgs";
    ## SECRET MANAGEMENT ----------------------------------------
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    ## THEMES ---------------------------------------------------
    catppuccin.url = "github:catppuccin/nix/release-25.11";
    ## FLATPAK
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    ## PERSONAL REPO --------------------------------------------
    suckless.url = "github:zrhive/suckless/main";
    suckless.flake = false;
    dotfiles.url = "path:./dotfiles";
    dotfiles.flake = false;
    secrets.url = "git@github.com:zhyie/nix-secrets.git";
    secrets.flake = false;
  };

  outputs =
    { ... }@inputs:
    let
      ## Hosts and their specifications
      hosts = import ./hosts;
      users = import ./users;
      ## Set of args to pass in
      args = { inherit inputs hosts users; };

      modules = import ./modules;
      lib = import ./lib args;
      inherit (lib)
        mapAttrs
        # listToAttrs
        mkNixos
        # mkHome
        eachSystem
        ;
    in
    {
      inherit lib modules;

      ## GENERATE HOSTS|HOMES CONFIGURATION
      nixosConfigurations = mapAttrs mkNixos hosts;
      # darwinConfigurations = mkDarwin hosts;
      # homeConfigurations = listToAttrs (mkHome users);

      ## EXPORT MODULES
      nixosModules = import ./modules/nixos;
      homeModules = import ./modules/home;

      overlays = import ./overlays { inherit inputs; };
      formatter = eachSystem (pkgs: pkgs.alejandra);
      packages = eachSystem (pkgs: import ./packages { inherit pkgs inputs; });
      devShells = eachSystem (pkgs: import ./shell.nix { inherit pkgs; });
    };
}
