{ config, lib, pkgs, ... }:

# let
#
#   outLink = config.lib.file.mkOutOfStoreSymlink;
#   homePath = config.home.homeDirectory;
#
# in
{
  home.file.".config/nvim" = {
    source = ../../config/nvim;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
  };
}
