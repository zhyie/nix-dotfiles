{ pkgs, inputs, ... }:

let
  inherit (builtins)
    attrNames
    readDir
    readFile
    listToAttrs
    replaceStrings
    map
    ;

  dir = inputs.dotfiles + "/scripts";
  scripts = attrNames (readDir dir);
  mkScript = name: pkgs.writeScriptBin name (readFile (dir + "/${name}.sh"));
in
listToAttrs (
  map (
    script:
    let
      name' = replaceStrings [ ".sh" ] [ "" ] script;
    in
    {
      name = name';
      value = mkScript name';
    }
  ) scripts
)
