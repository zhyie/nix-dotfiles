{ inputs, ... }@args:
/**
  args = { inherit inputs hosts users modules; };
*/
let
  callLibs = f: import f (args // { inherit (inputs.self) lib; });
in
rec {
  host = callLibs ./host;
  platform = callLibs ./platform.nix;

  inherit (host)
    mkNixos
    mkDarwin
    mkHome
    homeModule
    homeDefault
    ;
  inherit (platform)
    isLinux
    isDarwin
    systemList
    eachSystem
    ;
}
