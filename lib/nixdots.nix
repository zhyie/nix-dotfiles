{ config, lib, ... }:

let
  inherit (lib) mkOption types;
in
{
  options.nixdots = {
    path = mkOption {
      type = types.str;
      default = "nixos-config";
      description = "User specific flake directory name";
    };
  };

  config = {
    nixdots = "${config.home.homeDirectory}/${config.nixdots.path}";
  };
}
