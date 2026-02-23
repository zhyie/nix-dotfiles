{ pkgs, ... }:

{
  home.file.".config/nvim" = {
    source = ./.;
    recursive = true;
  };

  programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
  };
}
