{ config, pkgs, ... }:
{
  home.sessionVariables.VISUAL = "nvim";

  programs.neovim = {
    enable = config.modules.dev.enable;
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;
    viAlias = true;
    withNodeJs = true;

    extraLuaPackages = p: [
      p.luacheck
      p.luarocks
    ];

    extraPackages =
      builtins.attrValues {
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
          # nixfmt
          # deadnix
          # statix
          ;
      }
      ++ [
        pkgs.lua54Packages.luarocks
        pkgs.luajitPackages.luarocks
      ];

    plugins = [
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
        p.nix
      ]))
    ];
  };
}
