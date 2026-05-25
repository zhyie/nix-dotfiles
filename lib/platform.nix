{
  fn,
  lib,
  inputs,
  hosts,
  ...
}:
{
  isPlatform =
    platform: value: function:
    if value == platform then function else null;

  isPlatformElse =
    platform: value: function: elseFunction:
    if value == platform then function else elseFunction;

  genNixos = platform: fn.isPlatform "nixos" platform;
  genDarwin = platform: fn.isPlatform "darwin" platform;
  genWsl = platform: fn.isPlatform "wsl" platform;
  genDroid = platform: fn.isPlatform "droid" platform;

  isLinux = platform: lib.hasSuffix "linux" platform;
  isDarwin = platform: lib.hasSuffix "darwin" platform;

  forLinux = platform: function: if fn.isLinux platform then function else null;
  forDarwin = platform: function: if fn.isDarwin platform then function else null;

  systemList = lib.unique (lib.attrValues (lib.mapAttrs (_: host: host.system) hosts));
  eachSystem =
    function: lib.genAttrs fn.systemList (system: function inputs.nixpkgs.legacyPackages.${system});
}
