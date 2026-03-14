let
  path = builtins.path {
    path = ./.;
    name = "nixflake";
  };
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);

  n = lock.nodes.nixpkgs.locked;
  nixpkgs = fetchTarball {
    url = "https://github.com/${n.owner}/${n.repo}/archive/${n.rev}.tar.gz";
    sha256 = n.narHash;
  };

  system = builtins.currentSystem;
  overlays = [];

  flake = import ./flake.nix;
in
{
  pkgs = import nixpkgs { inherit system overlays; };

  nixos = import ./nixos;
  home = import ./home;
  lib = import ./lib;

  # host = ./hosts { inherit (flake) inputs; };
  hosts = builtins.attrNames (builtins.readDir ./hosts);
  users = builtins.attrNames (builtins.readDir ./users);

  inherit path;
}
