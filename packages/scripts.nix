{
  writeScriptBin,
  symlinkJoin,
  inputs,
}:
let
  inherit (builtins)
    attrNames
    readDir
    readFile
    replaceStrings
    map
    ;

  dir = inputs.dotfiles + "/scripts";
  scripts' = attrNames (readDir dir);
  scripts = map (s: replaceStrings [ ".sh" ] [ "" ] s) scripts';
  mkScript = name: writeScriptBin name (readFile (dir + "/${name}.sh"));
  paths = map mkScript scripts;
in
symlinkJoin {
  name = "scripts";
  inherit paths;
}
