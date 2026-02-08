{ config, lib, pkgs, ... }:

let
  cfg = config.services.dwmblocks;
  configFile = format.generate "dwm"
in
{

  options = {
    services.dwmblocks = {
      enable = lib.mkEnableOption "dwmblocks";
      package = lib.mkOption {
	type = lib.types.package;
	default = pkgs.dwmblocks;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.dwm-status = {
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig.ExecStart = "${cfg.package}/bin/dwmblocks ${configFile} --quiet";
    };
  }
}
