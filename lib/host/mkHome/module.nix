{
  inputs,
  users,
  modules,
  hostName,
  hostConfig,
  userName,
  ...
}:

let
  userConfig = users.${userName};
  homeDefault = import ./home.nix { inherit hostConfig userName; };
in
{
  home-manager = {
    extraSpecialArgs = {
      inherit (modules) home;
      inherit
        inputs
        userName
        userConfig
        hostName
        hostConfig
        ;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    overwriteBackup = true;
  }
  // (
    if hostConfig.platform == "droid" then
      { config = homeDefault; }
    else
      {
        users.${userName} = {
          imports = [
            homeDefault
            userConfig.home
            modules.common
          ];
        };
      }
  );
}
