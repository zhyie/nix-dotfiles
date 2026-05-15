{
  # lib,
  inputs,
  users,
  hostConfig,
  userName,
  ...
}:
let
  # inherit (lib) genAttrs;
  # inherit (hostConfig) userList;

  extraSpecialArgs = {
    inherit inputs userName;
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
        users.${userName}.home
      ];
    };
    # users = genAttrs userList (userName: {
    #   imports = [
    #     (import ./home.nix { inherit hostConfig userName; })
    #     users.${userName}.home
    #   ];
    # });
  };
}
