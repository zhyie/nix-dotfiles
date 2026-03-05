{ lib, userList, ... };

let
  inherit (lib) genAttrs;
in

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = extraArgs;
    users = genAttrs userList (user: {
      imports = [
        (home.default { inherit user; })
        users.${user}.home
      ];
    })
  };
}
