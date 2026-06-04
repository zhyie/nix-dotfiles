{
  lib',
  inputs,
  lib,
  users,
  modules,
  hostName,
  hostConfig,
  ...
}@args:

let
  userName = builtins.head hostConfig.users;
  userModule = lib.toList users.${userName}.default;
  homeModule = lib'.homeModule (args // { inherit userName; });

  baseModules = hostConfig.module ++ userModule;
in
lib.nixOnDroidConfiguration {
  pkgs = inputs.nixpkgs-droid.legacyPackages.${hostConfig.system};
  home-manager-path = inputs.home-manager-droid.outPath;
  modules = if hostConfig.withHome then baseModules ++ homeModule else baseModules;

  extraSpecialArgs = {
    inherit (modules) droid;
    inherit
      inputs
      hostName
      hostConfig
      lib'
      ;
  };
}
