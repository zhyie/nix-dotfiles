{ lib, inputs, ... }@args:

let
  inherit (inputs.self) nixosConfigurations;
  inherit (lib)
    isLinux
    isDarwin
    concatLists
    mapAttrs
    attrValues
    map
    ;

  callHost = f: extraArgs: import f (args // extraArgs);
in
{
  mkNixos =
    hostName: hostConfig:
    isLinux hostConfig.system (callHost ./mkNixos.nix { inherit hostName hostConfig; });

  mkDarwin =
    hostName: hostConfig:
    isDarwin hostConfig.system (callHost ./mkDarwin.nix { inherit hostName hostConfig; });

  mkHome =
    attrs:
    let
      hostList =
        hostName: hostConfig:
        map (userName: {
          name = userName + "@" + hostName;
          value =
            if hostConfig.withHome then
              nixosConfigurations.${hostName}.config.home-manager.users.${userName}
            else
              callHost ./mkHome { inherit userName hostName hostConfig; };
        }) hostConfig.userList;
    in
    concatLists (attrValues (mapAttrs hostList attrs));

  mkHost =
    hostName: hostConfig:
    let
      extraArgs = { inherit hostName hostConfig; };
    in
    if lib.hasSuffix "linux" hostConfig.system then
      callHost import ./mkNixos.nix extraArgs
    else
      callHost ./host/mkDarwin.nix extraArgs;
}
