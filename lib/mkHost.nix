{
  inputs, lib, xmodules, users, modules, home, dots, scripts,
  host, system, userList, moduleList ? [], stateVersion,
  ...
}:

let
  inherit (inputs) home-manager;
  inherit (lib) genAttrs attrValues flatten nixosSystem;

  specialArgs = {
    inherit inputs modules home dots scripts
      host userList stateVersion;
  };

  userModules = genAttrs userList (user: [ users.${user}.default ]);
  extraModules = flatten (xmodules ++ moduleList ++ (attrValues userModules));

  homeManager = home-manager.nixosModules.home-manager;
in

nixosSystem {
  inherit system specialArgs;
  # specialArgs = extraArgs;

  modules = extraModules ++ [
    homeManager {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecialArgs = specialArgs;
        users = genAttrs userList (user: {
          imports = [
            (home.default { inherit user; })
            users.${user}.home
          ];
        });
      };
    }
    # (homeManager (home.nixos {inherit lib userList; }))
  ];
}
