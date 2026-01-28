{ config, pkgs, ... }:

{

  #home.packages = with pkgs; [ neovim ];
  home.file."./.config/nvim/" = {
    source = ../../.config/nvim;
    recursive = true;
  };

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
  };

}
