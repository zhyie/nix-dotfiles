{
  lib,
  inputs,
  users,
  modules,
  userName,
  hostName,
  hostConfig,
  ...
}:

let
  userConfig = users.${userName};
  homeDefault = import ./home.nix { inherit hostConfig userName; };
in
lib.homeManagerConfiguration {
  pkgs = inputs.nixpkgs.legacyPackages.${hostConfig.system};

  extraSpecialArgs = {
    inherit (modules) home;
    inherit
      inputs
      userName
      userConfig
      hostName
      hostConfig
      ;
  };

  modules = [
    homeDefault
    userConfig.home
  ];
}
