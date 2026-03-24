{
  inputs,
  home,
  system,
  ...
}:

let
  inherit (inputs) nixpkgs home-manager;

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  extraArgs = { inherit inputs home; };

  homeConfiguration = home-manager.lib.homeManagerConfiguration;
in

homeConfiguration {
  inherit pkgs;
  extraSpecialArgs = extraArgs;
  modules = [
  ];
}
