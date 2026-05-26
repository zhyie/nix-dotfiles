{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) mkOption types genAttrs;
  inherit (types) listOf str;
  inherit (config.home) homeDirectory;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.variables) flake;
  cfg = config.dotfiles;
in
{
  options.dotfiles = {
    configFiles = mkOption {
      type = listOf str;
      default = [ ];
      description = ''
        List of configs to be set to {option}`xdg.config`.
      '';
    };
    homeFiles = mkOption {
      type = listOf str;
      default = [ ];
      description = ''
        List of files to be set to {option}`home.file`.
      '';
    };
  };

  config = {
    xdg.configFile = genAttrs cfg.configFiles (file: {
      source = mkOutOfStoreSymlink "${homeDirectory}/${flake.name}/dotfiles/${file}";
    });

    home.file = genAttrs cfg.homeFiles (file: {
      source = inputs.dotfiles + "/${file}";
    });
  };
}
