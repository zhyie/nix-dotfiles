{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs = {
    nushell = {
      enable = config.modules.dev.enable;
      # configFile.source =
      #   let
      #     inherit (config.lib.file) mkOutOfStoreSymlink;
      #     inherit (config.home) homeDirectory;
      #     inherit (config.vars) path;
      #   in
      #   mkOutOfStoreSymlink "${homeDirectory}/${path}/dotfiles/nushell/config.nu";
    };

    bash.initExtra = lib.optionalString config.programs.nushell.enable ''
      if ! [ "$TERM" = "dumb" ] && [ -z "$BASH_EXECUTION_STRING" ]; then
        exec ${pkgs.nushell}/bin/nu
      fi
    '';
  };
}
