{ config, lib, ... }:

let
  inherit (lib) mkOption types genAttrs;
  cfg = config.dotfiles;
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  imports = [ ./variables.nix ];

  options.dotfiles = {
    configFiles = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = ''
        List of configs to be set to {option}`xdg.config`.
      '';
    };
  };

  config = {
    xdg.configFile = genAttrs cfg.configFiles (name: {
      source = symlink "${config.home.homeDirectory}/.os/dotfiles/${name}";
    });
  };
}
