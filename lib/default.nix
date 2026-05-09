{ ... }@args:
/**
  args = { inherit inputs hosts users; };
*/
let
  callLibs = f: import f (args // { inherit (args.inputs.self) lib; });
in
rec {
  host = callLibs ./host;
  platform = callLibs ./platform.nix;
  config = callLibs ./config.nix;

  inherit (host)
    mkNixos
    mkDarwin
    mkHost
    mkHome
    ;
  inherit (platform)
    isLinux
    isDarwin
    systemList
    eachSystem
    ;
  inherit (config)
    hostConfig
    userConfig
    ;
}
