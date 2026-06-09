{
  inputs,
  writeScriptBin,
  symlinkJoin,
}:

let
  directory = inputs.dotfiles + "/scripts";

  scripts = map (script: builtins.replaceStrings [ ".sh" ] [ "" ] script) (
    builtins.attrNames (builtins.readDir directory)
  );

  mkScript = name: writeScriptBin name (builtins.readFile "${directory}/${name}.sh");
in
symlinkJoin {
  name = "scripts";
  paths = map mkScript scripts;
}
