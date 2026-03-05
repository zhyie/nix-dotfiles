{ lib, pkgs, home, scripts, ... }:

let
  inherit (lib) attrValues;
  sc = scripts { inherit pkgs; };
in

{
  # home.packages = with pkgs; [
  #   (writeScriptBin "hello" ''
  #     ${builtins.readFile ../../scripts/hello.sh}
  #   '')
  # ];
  home.packages = attrValues {
    inherit (pkgs) qutebrowser;
    inherit (sc) hello;
  };

  home.file = {
    ".gitconfig" = { source = ./.gitconfig; };
  };

  imports = [
    home.programs.default
    home.services.default
    home.themes.default
  ];
}
