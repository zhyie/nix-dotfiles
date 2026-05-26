{ pkgs, lib, ... }:
{
  # Install kitty package
  home.packages = [ pkgs.kitty ];

  programs.bash.initExtra = ''
    if test -n "$KITTY_INSTALLATION_DIR"; then
      export KITTY_SHELL_INTEGRATION="no-rc"
      source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"
    fi
  '';

  programs.git.iniContent = {
    diff = {
      tool = lib.mkDefault "kitty";
      guitool = lib.mkDefault "kitty.gui";
    };
    difftool = {
      prompt = lib.mkDefault false;
      trustExistCode = lib.mkDefault true;
      kitty = {
        cmd = "kitten diff $LOCAL $REMOTE";
      };
      "kitty.gui" = {
        cmd = "kitten diff $LOCAL $REMOTE";
      };
    };
  };
}
