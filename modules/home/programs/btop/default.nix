{ pkgs, ... }:
{
  programs.btop = {
    enable = true;
    package = pkgs.unstable.btop;
  };
}
