{
  lib,
  inputs,
  users,
  hostName,
  hostConfig,
  ...
}@args:

let
  inherit (lib) nixosSystem;
  inherit (hostConfig)
    module
    system
    userList
    profiles
    withHome
    ;

  homeModule = map (userName: import ./mkHome/module.nix (args // { inherit userName; })) userList;
  # homeModule = import ./mkHome/module.nix args;
  homeManager = [ inputs.home-manager.nixosModules.home-manager ] ++ homeModule;

  userModule = map (user: users.${user}.default) userList;
  hostProfiles = map (profile: inputs.self.nixosModules.profiles.${profile}) (
    if profiles == null then [ "base" ] else [ "base" ] ++ profiles
  );

  baseModules = module ++ userModule ++ hostProfiles;
  modules = if withHome then baseModules ++ homeManager else baseModules;

  specialArgs = {
    inherit inputs hostName hostConfig;
    inherit (inputs.self) lib';
    nixos = inputs.self.nixosModules;
  };
in
nixosSystem { inherit system specialArgs modules; }
