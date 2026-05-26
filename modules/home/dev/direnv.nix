{ config, ... }:
{
  programs.direnv = {
    enable = config.modules.dev.enable;
    silent = true;
    nix-direnv.enable = true;
  };
}
