let
  path = builtins.path { path = ./.; };

  lock = builtins.fromJSON (builtins.readFile ./flake.lock);

  n = lock.nodes.nixpkgs.locked;
  nixpkgs = fetchTarball {
    url = "https://github.com/${n.owner}/${n.repo}/archive/${n.rev}.tar.gz";
    sha256 = n.narHash;
  };
in
{
  inherit nixpkgs path;
}
