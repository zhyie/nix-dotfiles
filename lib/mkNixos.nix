{ host, cfg, ... }@args:

let
  inherit (args)
    self
    inputs
    lib
    hosts
    nixos
    home
    users
    ;
  inherit (cfg) system userList;
  inherit (lib) genAttrs attrValues flatten;

  specialArgs = {
    inherit
      self
      inputs
      nixos
      host
      userList
      ;
  };

  userModule = genAttrs userList (user: [ users.${user}.default ]);
  modules = [
    (home.nixos (args // { inherit userList; }))
    inputs.home-manager.nixosModules.home-manager
  ]
  ++ hosts.${host}.imports
  ++ (flatten (attrValues userModule));
in
lib.nixosSystem { inherit system specialArgs modules; }
