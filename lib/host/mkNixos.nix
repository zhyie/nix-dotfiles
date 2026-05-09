{
  lib,
  inputs,
  users,
  hostName,
  hostConfig,
  ...
}@args:
let
  inherit (hostConfig)
    module
    system
    userList
    profileList
    withHome
    ;
  inherit (lib) nixosSystem;

  inherit (inputs.home-manager.nixosModules) home-manager;
  mkHomeNixos = import ./mkHome/nixos.nix args;

  specialArgs = {
    inherit inputs hostName hostConfig;
    nixos = inputs.self.nixosModules;
  };

  hostProfiles = map (profile: inputs.self.nixosModules.profiles.${profile}) (
    if profileList == null then [ "minimal" ] else [ "minimal" ] ++ profileList
  );
  userModule = map (user: users.${user}.default) userList;
  homeManager = [
    home-manager
    mkHomeNixos
  ];
  baseModule = module ++ userModule ++ hostProfiles;
  modules = if withHome then baseModule ++ homeManager else baseModule;
in
nixosSystem { inherit system specialArgs modules; }
