{ inputs, ... }@args:
/**
  args = { inherit inputs hosts users modules; };
*/
let
  callLibs = f: import f (args // { inherit (inputs.self) fn; });
in
rec {
  host = callLibs ./host;
  platform = callLibs ./platform.nix;

  inherit (host)
    callHost
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
    genNixos
    genDarwin
    genWsl
    genDroid
    isLinux
    isDarwin
    forLinux
    forDarwin
    systemList
    eachSystem
    ;
}
