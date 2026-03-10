{ config, lib, pkgs, dots, ... }:

let
  outLink = config.lib.file.mkOutOfStoreSymlink;
  homePath = config.home.homeDirectory;

  cfg = config.mods;
in

{
  xdg.configFile."nvim" = {
    source = outLink "${homePath}/.dotfiles/dotfiles/nvim";
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;

    # plugins = builtins.attrValues {
    #   inherit (pkgs.vimPlugins)
    #   nvim-treesitter.withAllGrammars
    #   plenary-nvim
    # };
  };
}
