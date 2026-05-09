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
  inherit (config.vars) path;
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
    xdg.configFile = genAttrs cfg.configFiles (name: {
      source = mkOutOfStoreSymlink "${homeDirectory}/${path}/dotfiles/${name}";
    });

    home.file = genAttrs cfg.homeFiles (name: {
      source = inputs.dotfiles + "${name}";
    });
  };
}
