{
  inputs,
  users,
  modules,
  hostName,
  hostConfig,
  homeModule,
  ...
}@args:

let
  userName = builtins.head hostConfig.users;
  userModule = [ users.${userName}.user ];
  baseModules = hostConfig.module ++ userModule;

  homeModules = homeModule (args // { inherit userName; });
in
inputs.nix-on-droid.lib.nixOnDroidConfiguration {
  modules = if hostConfig.withHome then baseModules ++ homeModules else baseModules;

  pkgs = inputs.nixpkgs-droid.legacyPackages.${hostConfig.system};
  # pkgs = import inputs.nixpkgs-droid {
  #   inherit (hostConfig) system;
  #   overlays = builtins.attrValues inputs.self.overlays ++ [
  #     inputs.nix-on-droid.overlays.default
  #   ];
  # };

  extraSpecialArgs = {
    inherit (modules) droid;
    inherit
      inputs
      hostName
      hostConfig
      ;
  };
}
// (inputs.nixpkgs.lib.optionalAttrs hostConfig.withHome {
  home-manager-path = inputs.home-manager-droid.outPath;
})
