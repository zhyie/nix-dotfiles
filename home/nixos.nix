{ cfg, ... } @ xargs: let

  inherit (xargs) inputs lib users home;
  # inherit (inputs) home-manager;
  inherit (lib) genAttrs;
  inherit (cfg) userList stateVersion;

  extraSpecialArgs = {
    inherit inputs home;
    inherit (xargs) dots scripts;
  };

in
{

  home-manager = {
    inherit extraSpecialArgs;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    #extraSpecialArgs = extraArgs;
    users = genAttrs userList (user: {
      imports = [
        (home.default { inherit user stateVersion; })
        users.${user}.home
      ] ++ users.${user}.moduleList;
    });
  };

}
