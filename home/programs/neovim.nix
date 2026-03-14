{ config, lib, pkgs, dots, ... }:

let
  outLink = config.lib.file.mkOutOfStoreSymlink;
  homePath = config.home.homeDirectory;

  cfg = config.mods;
in

{
  xdg.configFile."nvim" = {
    source = outLink "${homePath}/.os/dotfiles/nvim";
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    withNodeJs = true;

    extraPackages = builtins.attrValues {
      inherit (pkgs)
        cargo clang
        ripgrep fzf
        lua-language-server stylua
        nixd nixfmt-tree deadnix
      ;
    };

    # plugins = builtins.attrValues {
    #   inherit (pkgs.vimPlugins)
    #     inherit (nvim-treesitter-parsers)
    #       lua nix c markdown
    #     ;
    #
    #     telescope-nvim
    #     telescope-fzf-native-nvim
    #     plenary-nvim
    #
    #     blink-cmp
    #     friendly-snippets
    #     conform-nvim
    #     nvim-lint
    #
    #     alpha-nvim
    #     catppuccin-nvim
    #     lualine-nvim
    #     nvim-web-devicons
    #     yazi-nvim
    #     mini-nvim
    #   ;
    # };
  };
}
