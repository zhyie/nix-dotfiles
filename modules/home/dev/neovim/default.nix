{ pkgs, ... }:
{
  home.sessionVariables = {
    VISUAL = "nvim";
  };

  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;
    viAlias = true;
    withNodeJs = true;

    extraLuaPackages = p: [ p.luacheck ];
    extraPackages = builtins.attrValues {
      inherit (pkgs)
        ripgrep
        fzf
        xclip
        git
        tree-sitter
        lua-language-server
        stylua
        clang
        clang-tools
        nixd
        nixfmt
        deadnix
        statix
        ;
    };

    plugins = [
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
        p.nix
      ]))
    ];
  };
}
