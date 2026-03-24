let
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);

  n = lock.nodes.nixpkgs.locked;
  nixpkgs = fetchTarball {
    url = "https://github.com/${n.owner}/${n.repo}/archive/${n.rev}.tar.gz";
    sha256 = n.narHash;
  };

  path = builtins.path {
    path = ./.;
    name = "zhynix";
  };
in
{
  inherit nixpkgs path;
}
