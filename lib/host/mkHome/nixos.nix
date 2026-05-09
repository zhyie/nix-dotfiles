{
  lib,
  inputs,
  hostConfig,
  users,
  ...
}:
let
  inherit (lib) genAttrs;
  inherit (hostConfig) userList;

  extraSpecialArgs = {
    inherit inputs;
    home = inputs.self.homeModules;
  };
in
{
  home-manager = {
    inherit extraSpecialArgs;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users = genAttrs userList (userName: {
      imports = [
        (import ./home.nix { inherit hostConfig userName; })
        users.${userName}.home
      ];
    });
  };
}
