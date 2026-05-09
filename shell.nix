{ pkgs }:
{
  default = pkgs.mkShellNoCC {
    packages = builtins.attrValues {
      inherit (pkgs)
        git
        tree
        nixfmt
        nixfmt-tree
        statix
        deadnix
        ;
    };
  };
}
