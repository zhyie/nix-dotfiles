{ config, lib, ... }:

let
  inherit (lib) mkOption types map;
in
{
  options.vars = {
    profile = mkOption {
      type = types.listOf;
      default = [ "minimal" ];
      description = "Host profile";
    };
  };

  config.importProfiles = map (profile: import ./${profile}.nix) config.vars.profiles;
}
