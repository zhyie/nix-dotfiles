{
  lib',
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
    profiles
    withHome
    ;

  homeModule = map (userName: lib'.homeModule (args // { inherit userName; })) hostConfig.users;
  homeManager = [ inputs.home-manager.nixosModules.home-manager ] ++ homeModule;

  userModule = map (user: users.${user}.default) hostConfig.users;
  hostProfiles = map (profile: inputs.self.nixosModules.profiles.${profile}) (
    if profiles == null then [ "base" ] else [ "base" ] ++ profiles
  );

  baseModules = module ++ userModule ++ hostProfiles;
  modules = if withHome then baseModules ++ homeManager else baseModules;

  specialArgs = {
    inherit
      inputs
      hostName
      hostConfig
      lib'
      ;
    nixos = inputs.self.nixosModules;
  };
in
nixosSystem { inherit system specialArgs modules; }
