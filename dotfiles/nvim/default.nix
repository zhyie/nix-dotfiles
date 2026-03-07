{ pkgs, ... }:

{
  xdg.configFile"nvim" = {
    source = builtins.readFile (builtins.toString ./.);
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
  };
}
