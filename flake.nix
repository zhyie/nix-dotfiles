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
    secrets.url = "git+ssh://git@github.com/zhyie/nix-secrets.git?ref=main&shallow=1";
    secrets.flake = false;
    dotfiles.url = "path:./dotfiles";
    dotfiles.flake = false;
    suckless.url = "github:zrhive/suckless/main";
    suckless.inputs.nixpkgs.follows = "nixpkgs";
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
      lib = import ./lib args // inputs.nixpkgs.lib // inputs.home-manager.lib;
      inherit (lib)
        mapAttrs
        listToAttrs
        mkNixos
        mkHome
        eachSystem
        ;
    in
    {
      inherit lib modules;

      ## GENERATE HOSTS|HOMES CONFIGURATION
      nixosConfigurations = mapAttrs mkNixos hosts;
      # darwinConfigurations = mapAttrs mkDarwin hosts;
      homeConfigurations = listToAttrs (mkHome hosts);

      ## EXPORT MODULES
      nixosModules = import ./modules/nixos;
      homeModules = import ./modules/home;

      overlays = import ./overlays { inherit inputs; };
      formatter = eachSystem (pkgs: pkgs.nixfmt-tree);
      packages = eachSystem (pkgs: import ./packages { inherit pkgs inputs; });
      devShells = eachSystem (pkgs: import ./shell.nix { inherit pkgs; });

      # checks = eachSystem (pkgs: {
      #   nixos-eval = mapAttrs (
      #     host: _: inputs.self.nixosConfigurations.${host}.config.system.build.toplevel
      #   ) hosts;
      #   # pkgs = pkgs.runCommand "check-pkgs" ''
      #   #   ${package}/bin/package > $out
      #   # '';
      #   fmt = pkgs.runCommand "check-fmt" ''
      #     nixfmt --check ${./.}
      #     touch $out
      #   '';
      #   lint = pkgs.runCommand "check-lint" { buildInputs = [ pkgs.statix ]; } ''
      #     statix check ${./.}
      #     touch $out
      #   '';
      # });
    };
}
