{ pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    package = pkgs.unstable.nushell;
  };
}
