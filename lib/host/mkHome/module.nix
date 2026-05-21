{
  # lib,
  inputs,
  users,
  hostName,
  hostConfig,
  userName,
  ...
}:
let
  userConfig = users.${userName};

  extraSpecialArgs = {
    inherit
      inputs
      userName
      userConfig
      hostName
      hostConfig
      ;
    inherit (inputs.self) lib';
    home = inputs.self.homeModules;
  };
in
{
  home-manager = {
    inherit extraSpecialArgs;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.${userName} = {
      imports = [
        (import ./home.nix { inherit hostConfig userName; })
        userConfig.home
      ];
    };
  };
}
