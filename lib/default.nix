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
    homeModule
    homeDefault
    mkNixos
    mkDarwin
    mkDroid
    mkHome
    ;
  inherit (platform)
    filterNixos
    filterDarwin
    filterWsl
    filterDroid
    isLinux
    isDarwin
    systemList
    eachSystem
    ;
}
