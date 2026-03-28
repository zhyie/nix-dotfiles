{ pkgs }:
{
  default = pkgs.mkShellNoCC {
    packages = builtins.attrValues {
      inherit (pkgs)
        tree
        nixfmt
        nixfmt-tree
        ;
    };
  };
}
