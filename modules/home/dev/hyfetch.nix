{ pkgs, ... }:
{
  home.packages = [ pkgs.hyfetch ];
  # programs.hyfetch = {
  #   enable = true;
  #   settings = {
  #     preset = "sapphic";
  #   };
  # };
}
