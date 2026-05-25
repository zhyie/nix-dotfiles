{
  fn,
  inputs,
  users,
  hostName,
  hostConfig,
  userName,
  ...
}:
let
  userConfig = users.${userName};
  home = import ./home.nix { inherit userName hostConfig; };

  extraSpecialArgs = {
    inherit
      inputs
      userName
      userConfig
      hostName
      hostConfig
      ;
    inherit (inputs.self) fn;
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
  //
    fn.isPlatformElse "droid"
      {
        config = home;
      }
      {
        users.${userName} = {
          imports = [
            home
            userConfig.home
          ];
        };
      };
}
