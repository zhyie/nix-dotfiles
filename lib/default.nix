{ inputs, ... }@args:
/**
  args = { inherit inputs hosts users modules; };
*/
let
  callLibs = f: import f (args // { inherit (inputs.self) lib'; });
in
rec {
  host = callLibs ./host;
  platform = callLibs ./platform.nix;

  inherit (host)
    callHost
    mkHost

    mkNixos
    mkDarwin
    mkDroid
    mkHome

    homeModule
    homeDefault
    ;
  inherit (platform)
    isPlatform
    isPlatformElse

    isNixosPlatform
    isDarwinPlatform
    isWslPlatform
    isDroidPlatform

    genNixos
    genDarwin
    genWsl
    genDroid

    filterNixos
    filterDarwin
    filterWsl
    filterDroid

    isLinux
    isDarwin
    forLinux
    forDarwin

    systemList
    eachSystem
    ;
}
