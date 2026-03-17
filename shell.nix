let
  d = import ./.;
  pkgs = d.pkgs;
in
pkgs.mkShell {
  packages = builtins.attrValues {
    inherit (pkgs)
      tree
      nixfmt
      nixfmt-tree
      ;
  };
}
