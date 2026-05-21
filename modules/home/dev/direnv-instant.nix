{ config, inputs, ... }:
{
  imports = [ inputs.direnv-instant.homeModules.direnv-instant ];

  programs.direnv-instant.enable = config.modules.dev.enable;
}
