{ pkgs, ... }:
{
  services.xscreensaver = {
    enable = true;
    hooks = {

    };
  };

  programs.xscreensaver.enable = true;
}
