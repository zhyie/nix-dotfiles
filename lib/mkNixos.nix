{ self, inputs, lib, hosts, users, nixos, home, dots, scripts,
  host, system, userList, moduleList, stateVersion, ... }:

let
  inherit (lib) genAttrs attrValues flatten;

  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      self.overlays.unstable-packages
    ];
  };

  specialArgs = {
    inherit self inputs host nixos userList stateVersion;
  };

  extraSpecialArgs = {
    inherit self inputs home dots scripts stateVersion;
  };

  userDefault = genAttrs userList (user: [ users.${user}.default ]);
  extraModules = flatten (moduleList ++ (attrValues userDefault));

  #homeManager = inputs.home-manager.nixosModules.home-manager;
in

lib.nixosSystem {
  # system = "x86_64-linux";
  inherit system;
  #specialArgs = extraArgs;
  inherit specialArgs;
  # specialArgs = extraArgs;

  modules = extraModules ++ [
    # homeManager(xargs // cfg) ];
    # home.nixos { inherit args; }
    { nixpkgs.pkgs = pkgs; }
    inputs.home-manager.nixosModules.home-manager
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
          ];
        });
      };
    }
  ];
}
