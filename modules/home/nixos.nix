{ userList, ... }@args:

let
  inherit (args)
    inputs
    users
    home
    scripts
    ;
  inherit (inputs.nixpkgs.lib) genAttrs;
  # inherit (cfg) userList stateVersion;

  extraSpecialArgs = {
    inherit inputs home scripts;
  };
in
{
  home-manager = {
    inherit extraSpecialArgs;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users = genAttrs userList (user: {
      imports = [
        (home.default { inherit user; })
        users.${user}.home
      ];
    });
  };
}
