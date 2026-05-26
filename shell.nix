{ pkgs, self }:

let
  inherit (self.checks.${pkgs.stdenv.hostPlatform.system}.git-hooks)
    shellHook
    enabledPackages
    ;
in
pkgs.mkShellNoCC {
  inherit shellHook;
  buildInputs = enabledPackages;

  packages = [
    pkgs.home-manager
    pkgs.nh

    pkgs.macchina
    pkgs.bat
    pkgs.statix
  ];
}
