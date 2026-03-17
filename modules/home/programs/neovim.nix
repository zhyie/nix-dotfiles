{ config, pkgs, ... }:

let
  outLink = config.lib.file.mkOutOfStoreSymlink;
  homePath = config.home.homeDirectory;
in

{
  xdg.configFile."nvim" = {
    source = outLink "${homePath}/.os/dotfiles/nvim";
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;
    viAlias = true;
    withNodeJs = true;

    extraPackages = [
      pkgs.lua54Packages.luacheck
    ]
    ++ (builtins.attrValues {
      inherit (pkgs)
        ripgrep
        fzf
        xclip
        lua-language-server
        stylua
        nixd
        nixfmt-tree
        deadnix
        clang
        clang-tools
        cargo
        ;
    });

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
