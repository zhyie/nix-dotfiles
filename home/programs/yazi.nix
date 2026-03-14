{ pkgs, ... }:
{
  # home.packages = [ pkgs.yazi ];
  programs.yazi = {
    enable = true;
    package = pkgs.unstable.yazi;
    shellWrapperName = "y";
    # settings = lib.importTOML (inputs.dotfiles + "/yazi/yazi.toml");
    # keymap = lib.importTOML (inputs.dotfiles + "/yazi/keymap.toml");
    # theme = lib.importTOML (inputs.dotfiles + "/yazi/theme.toml");
    # initLua = inputs.dotfiles + "/yazi/init.lua";
    #
    # plugins = {
    #   inherit (pkgs.yaziPlugins)
    #     sudo mount
    #     full-border toggle-pane
    #     mediainfo ouch
    #     recycle-bin restore
    #     smart-enter smart-filter
    #   ;
    # } ++ {
    #
    # };
  };
}
