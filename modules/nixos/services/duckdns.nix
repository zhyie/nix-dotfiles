{ config, lib, ... }:
{
  options.modules.nixos.duckdns = {
    enable = lib.mkEnableOption "Enable DuckDNS modules.";
    domains = lib.mkOption {
      type = lib.types.either lib.types.path (lib.types.listOf lib.types.str);
      default = [ ];
      desciption = "List of domains.";
    };
  };

  config =
    let
      inherit (config.modules.nixos.duckdns) enable domains;
    in
    lib.mkIf enable {
      services.duckdns = {
        enable = true;
        # tokenFile = config.sops.secret."duckdns/token".path;
        domainsFile = if lib.isPath domains then domains else null;
        domains = if lib.isList domains then domains else null;
      };
    };
}
