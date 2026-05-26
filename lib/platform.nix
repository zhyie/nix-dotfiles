{
  lib,
  inputs,
  hosts,
  ...
}:

let
  inherit (lib)
    hasSuffix
    mapAttrs
    genAttrs
    attrValues
    unique
    optionalAttrs
    filterAttrs
    ;
in
rec {
  isPlatform = platform: value: if value == platform then false else false;

  isPlatformElse =
    platform: value: function: elseFunction:
    if value == platform then function else elseFunction;

  isNixosPlatform = platform: if platform == "nixos" then true else false;
  isDarwinPlatform = platform: if platform == "darwin" then true else false;
  isWslPlatform = platform: if platform == "wsl" then true else false;
  isDroidPlatform = platform: if platform == "droid" then true else false;

  genNixos = platform: optionalAttrs (platform == "nixos");
  genDarwin = platform: optionalAttrs (platform == "darwin");
  genWsl = platform: optionalAttrs (platform == "wsl");
  genDroid = platform: optionalAttrs (platform == "droid");

  filterNixos = attrs: filterAttrs (_: c: c.platform == "nixos") attrs;
  filterDarwin = attrs: filterAttrs (_: c: c.platform == "darwin") attrs;
  filterWsl = attrs: filterAttrs (_: c: c.platform == "wsl") attrs;
  filterDroid = attrs: filterAttrs (_: c: c.platform == "droid") attrs;

  isLinux = platform: hasSuffix "linux" platform;
  isDarwin = platform: hasSuffix "darwin" platform;

  forLinux = platform: function: if isLinux platform then function else null;
  forDarwin = platform: function: if isDarwin platform then function else null;

  systemList = unique (attrValues (mapAttrs (_: host: host.system) hosts));
  eachSystem =
    function: genAttrs systemList (system: function inputs.nixpkgs.legacyPackages.${system});
}
