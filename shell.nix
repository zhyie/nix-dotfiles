let
  pkgs = import (import ./.).nixpkgs {
    system = builtins.currentSystem;
  };
in
pkgs.mkShellNoCC {
  packages = builtins.attrValues {
    inherit (pkgs)
      tree
      nixfmt
      nixfmt-tree
      ;
  };
}
