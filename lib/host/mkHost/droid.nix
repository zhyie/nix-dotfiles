{
  lib',
  inputs,
  lib,
  users,
  hostName,
  hostConfig,
  ...
}@args:

let
  inherit (lib) nixOnDroidConfiguration;

  userName = builtins.head hostConfig.users;
  userModule = lib.toList users.${userName}.default;
  homeModule = lib'.homeModule (args // { inherit userName; });

  hostProfiles = map (profile: inputs.self.nixosModules.profiles.${profile}) (
    if hostConfig.profiles == [ ] then [ "base" ] else [ "base" ] ++ hostConfig.profiles
  );

  baseModules = hostConfig.module ++ userModule ++ hostProfiles;
in
nixOnDroidConfiguration {
  pkgs = inputs.nixpkgs-droid.legacyPackages.${hostConfig.system};
  home-manager-path = inputs.home-manager-droid.outPath;

  extraSpecialArgs = {
    inherit
      inputs
      hostName
      hostConfig
      lib'
      ;
    droid = inputs.self.modules.droid;
  };

  modules = if hostConfig.withHome then baseModules ++ homeModule else baseModules;
}
