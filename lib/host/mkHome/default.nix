{
  lib,
  inputs,
  users,
  userName,
  hostName,
  hostConfig,
  ...
}:
let
  inherit (lib) homeManagerConfiguration;
  inherit (hostConfig) system;
  userConfig = users.${userName};
  defaultHome = import ./home.nix { inherit hostConfig userName; };

  # pkgs = import inputs.nixpkgs { inherit system; };
  pkgs = inputs.nixpkgs.legacyPackages.${system};

  extraSpecialArgs = {
    inherit
      inputs
      userName
      userConfig
      hostName
      hostConfig
      ;
    home = inputs.self.homeModules;
  };

  modules = [
    defaultHome
    userConfig.home
  ];
in
homeManagerConfiguration { inherit pkgs extraSpecialArgs modules; }
