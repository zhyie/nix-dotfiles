{ inputs, outputs, ... }:

{ username, stateVersion }:

let

  pkgs = outputs.pkgs;
  home-manager = inputs.home-manager.lib.homeManagerConfiguration;

  home = import ../${username}/home.nix { inherit username stateVersion };

in home-manager {

  inherit pkgs;
  
  modules = [ home ];

}

/*

let 

  # assume pkgs and stateVersion are defined

  mkHome = import ./home { inherit inputs outputs }

  users = { "alice", "emma" }

in {

  homeConfigurations = {

    "username@hostname" = mkHome { "username", stateVersion };

  }

}

*/
