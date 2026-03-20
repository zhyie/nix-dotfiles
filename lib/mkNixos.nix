{ host, cfg, ... }@args:

let
  inherit (args)
    self
    inputs
    hosts
    nixos
    home
    users
    ;
  inherit (cfg) system userList;
  inherit (inputs.nixpkgs.lib)
    genAttrs
    attrValues
    flatten
    nixosSystem
    ;

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
nixosSystem { inherit system specialArgs modules; }
