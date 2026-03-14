{ config, lib, dots, ... }:

let
  inherit (lib) mkOption types genAttrs;
  cfg = config.dotfiles;

  outLink = config.lib.file.mkOutOfStoreSymlink;
in
{
  options = {
    dotfiles = {
      configFiles = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = ''
          List of configs to be set to {option}`xdg.config`.
        '';
      };
    };
  };

  config = {
    xdg.configFile = genAttrs cfg.configFiles (name: {
      source = outLink "${config.home.homeDirectory}/.os/dotfiles/${name}";
      # recursive = true;
    });
  };
}
