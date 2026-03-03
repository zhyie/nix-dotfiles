{ lib, pkgs, home, ... }:

{
  home.packages = with pkgs; [
    (writeScriptBin "hello" ''
      ${builtins.readFile ../../scripts/hello.sh}
    '')
  ];

  home.sessionPath = [ "$HOME/.dotfiles/scripts/top" ];

  # Import packages.
  imports = [
    home.programs.default
    home.services.default
    home.themes.default
  ];
}
