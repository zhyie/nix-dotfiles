{
  fn,
  lib,
  inputs,
  ...
}@args:

let
  inherit (inputs.self) nixosConfigurations;
  inherit (fn)
    callHost
    genNixos
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
{
  callHost = f: extraArgs: import f (args // extraArgs);
  homeModule = import ./mkHome/module.nix;
  homeDefault = import ./mkHome/home.nix;

  mkNixos =
    hostName: hostConfig:
    genNixos hostConfig.platform (callHost ./mkHost/nixos.nix { inherit hostName hostConfig; });

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
}
