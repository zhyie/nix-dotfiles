{ pkgs }:
{
  default = pkgs.mkShellNoCC {
    packages = [
      pkgs.home-manager
      pkgs.nixfmt
      pkgs.git
    ];
  };

  sops = pkgs.mkShellNoCC { packages = [ pkgs.sops ]; };
}
