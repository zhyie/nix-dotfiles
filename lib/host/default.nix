{ inputs, ... }@args:

rec {
  callHost = f: extraArgs: import f (args // extraArgs);

  homeModule = import ./mkHome/module.nix;
  homeDefault = import ./mkHome/home.nix;

  mkNixos =
    hostName: hostConfig: callHost ./mkHost/nixos.nix { inherit hostName hostConfig homeModule; };

  mkDarwin =
    hostName: hostConfig: callHost ./mkHost/darwin.nix { inherit hostName hostConfig homeModule; };

  mkDroid =
    hostName: hostConfig: callHost ./mkHost/droid.nix { inherit hostName hostConfig homeModule; };

  mkHome =
    attrs:
    let
      hostList =
        hostName: hostConfig:
        map (userName: {
          name = userName + "@" + hostName;
          value =
            if hostConfig.withHome then
              inputs.self.nixosConfigurations.${hostName}.config.home-manager.users.${userName}.home
            else
              callHost ./mkHome { inherit userName hostName hostConfig; };
        }) hostConfig.users;
    in
    builtins.concatLists (builtins.attrValues (builtins.mapAttrs hostList attrs));
}
