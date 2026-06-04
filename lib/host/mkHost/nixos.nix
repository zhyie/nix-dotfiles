{
  lib',
  lib,
  inputs,
  users,
  modules,
  hostName,
  hostConfig,
  ...
}@args:

let
  homeModule = map (userName: lib'.homeModule (args // { inherit userName; })) hostConfig.users;
  homeManager = [ inputs.home-manager.nixosModules.home-manager ] ++ homeModule;

  userModule = map (user: users.${user}.default) hostConfig.users;
  baseModules =
    hostConfig.module
    ++ userModule
    ++ [
      modules.common
      modules.nixos
    ];
in
lib.nixosSystem {
  inherit (hostConfig) system;
  modules = if hostConfig.withHome then baseModules ++ homeManager else baseModules;

  specialArgs = {
    inherit (modules) home;
    inherit
      inputs
      hostName
      hostConfig
      lib'
      ;
  };
}
