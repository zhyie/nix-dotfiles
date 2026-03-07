let
  pkgs = import <nixpkgs> {};
in

pkgs.mkShell {
  packages = with pkgs; [
    nixfmt-tree git sops age cargo nodejs
  ];
}
