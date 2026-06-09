{ config, pkgs, ... }:
{
  home.sessionVariables.VISUAL = "nvim";

  programs.neovim = {
    enable = config.modules.dev.enable;
    defaultEditor = true;
    viAlias = true;
    # withNodeJs = true;
    withPython3 = false;
    withRuby = false;
    sideloadInitLua = true;

    extraPackages = [
      pkgs.lua54Packages.luacheck
    ]
    ++ builtins.attrValues {
      inherit (pkgs)
        ripgrep
        fzf
        xclip
        gitMinimal
        tree-sitter
        ;
    };

    plugins = [
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
        p.nix
      ]))
    ];
  };
}
