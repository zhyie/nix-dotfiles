{ config, pkgs, ... }:
{
  home.sessionVariables.VISUAL = "nvim";

  programs.neovim = {
    enable = config.modules.dev.enable;
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;
    viAlias = true;
    withNodeJs = true;

    extraPackages = [
      pkgs.lua54Packages.luacheck
    ]
    ++ builtins.attrValues {
      inherit (pkgs)
        ripgrep
        fzf
        xclip
        git
        tree-sitter
        # lua-language-server
        # stylua
        # clang
        # clang-tools
        # nixd
        nixfmt
        # deadnix
        # statix
        ;
    };

    plugins = [
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
        p.nix
      ]))
    ];
  };
}
