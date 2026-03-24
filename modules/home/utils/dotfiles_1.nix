{ config, lib, ... }:

let
  inherit (lib) mkOption types genAttrs;
  inherit (config.home) homeDirectory;
  inherit (config.lib.file) mkOutOfStoreSymlink;

  cfg = config.dotfiles;
  flake = config.flakePath;
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
      source = mkOutOfStoreSymlink "${homeDirectory}/${flake}/dotfiles/${name}";
    });
  };
}
