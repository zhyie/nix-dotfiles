# { pkgs ? import <nixpkgs> {} }:
let
  pkgs = import <nixpkgs> {};
in

pkgs.mkShell {
  packages = with pkgs; [
    git
    sops
    age
    cargo
    nodejs
  ];
}
