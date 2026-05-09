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
  # mkNixos = host: cfg: isLinux cfg.system (import ./mkNixos.nix (args // { inherit host cfg; }));
  mkNixos =
    hostName: hostConfig:
    isLinux hostConfig.system (callHost ./mkNixos.nix { inherit hostName hostConfig; });

  mkDarwin =
    hostName: hostConfig:
    isDarwin hostConfig.system (callHost ./mkDarwin.nix { inherit hostName hostConfig; });

  mkHome =
    attrs:
    let
      # mapHost =
      #   h: c:
      #   map (userName: {
      #     name = userName + "@" + h;
      #     value =
      #       if c.withHome then
      #         nixosConfigurations.${h}.config.home-manager.users.${userName}.home
      #       else
      #         callHost ./mkHome { inherit userName h c; };
      #   }) c.userList;
      # hostList = mapAttrs (hostName: hostConfig: mapHost hostName hostConfig) attrs;
      hostList = mapAttrs (
        hostName: hostConfig:
        map (userName: {
          name = userName + "@" + hostName;
          value =
            if hostConfig.withHome then
              nixosConfigurations.${hostName}.config.home-manager.users.${userName}
            else
              callHost ./mkHome { inherit userName hostName hostConfig; };
        }) hostConfig.userList
      ) attrs;
    in
    concatLists (attrValues hostList);

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
