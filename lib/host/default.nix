{
  lib',
  lib,
  inputs,
  ...
}@args:

let
  inherit (inputs.self) nixosConfigurations;
  inherit (lib')
    # callHost
    isLinux
    isNixosPlatform
    genDarwin
    genDroid
    ;
  inherit (lib)
    concatLists
    mapAttrs
    attrValues
    map
    ;
in
rec {
  callHost = f: extraArgs: import f (args // extraArgs);
  homeModule = import ./mkHome/module.nix;
  homeDefault = import ./mkHome/home.nix;

  mkNixos = hostName: hostConfig: callHost ./mkHost/nixos.nix { inherit hostName hostConfig; };

  mkDarwin =
    hostName: hostConfig:
    genDarwin hostConfig.platform (callHost ./mkHost/darwin.nix { inherit hostName hostConfig; });

  mkNixOnDroid =
    hostName: hostConfig:
    genDroid hostConfig.platform (callHost ./mkHost/droid.nix { inherit hostName hostConfig; });

  mkHome =
    attrs:
    let
      hostList =
        hostName: hostConfig:
        map (userName: {
          name = userName + "@" + hostName;
          value =
            if hostConfig.withHome then
              nixosConfigurations.${hostName}.config.home-manager.users.${userName}.home
            else
              callHost ./mkHome { inherit userName hostName hostConfig; };
        }) hostConfig.users;
    in
    concatLists (attrValues (mapAttrs hostList attrs));

  mkHost =
    hostName: hostConfig:
    let
      extraArgs = { inherit hostName hostConfig; };
    in
    if isLinux hostConfig.system then
      if isNixosPlatform hostConfig.platform then
        callHost ./mkHost/nixos.nix extraArgs
      else
        callHost ./mkHost/droid.nix extraArgs
    else
      callHost ./mkHost/darwin.nix extraArgs;
}
