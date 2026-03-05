{ pkgs, ... }:

let
  # pkgs = import <nixpkgs> { system = "x86_64-linux"; };

  mkScript = script: pkgs.writeScriptBin "${script}" (builtins.readFile ./${script}.sh);
in

{
  hello = mkScript "hello";
}
