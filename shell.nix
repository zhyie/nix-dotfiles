{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = [  ];
  inputsFrom = [  ];
  shellHook = ''
    echo "Entered nix shell!"
  '';
}
