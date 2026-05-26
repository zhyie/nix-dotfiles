{
  lib',
  inputs,
  users,
  hostName,
  hostConfig,
  userName,
  ...
}:
let
  userConfig = users.${userName};
  config = import ./home.nix { inherit userName hostConfig; };

  extraSpecialArgs = {
    inherit
      inputs
      userName
      userConfig
      hostName
      hostConfig
      lib'
      ;
    home = inputs.self.homeModules;
  };

  useGlobalPkgs = true;
  useUserPackages = true;
  backupFileExtension = "backup";
in
{
  home-manager = {
    inherit
      extraSpecialArgs
      useGlobalPkgs
      useUserPackages
      backupFileExtension
      ;
  }
  // lib'.isPlatformElse "droid" hostConfig.platform { inherit config; } {
    users.${userName} = {
      imports = [
        config
        userConfig.home
      ];
    };
  };
}
