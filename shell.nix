{ pkgs }:
{
  default = pkgs.mkShellNoCC {
    packages = builtins.attrValues {
      inherit (pkgs) git nixfmt deadnix;
    };
  };
}
