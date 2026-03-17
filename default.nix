let
  path = builtins.path {
    path = ./.;
    name = "zhynix";
  };

  lock = builtins.fromJSON (builtins.readFile ./flake.lock);

  n = lock.nodes.nixpkgs.locked;
  nixpkgs = fetchTarball {
    url = "https://github.com/${n.owner}/${n.repo}/archive/${n.rev}.tar.gz";
    sha256 = n.narHash;
  };

  system = builtins.currentSystem;
  overlays = [ ];
in
{
  pkgs = import nixpkgs { inherit system overlays; };

  inherit path nixpkgs;
}
