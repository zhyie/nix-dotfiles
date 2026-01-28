{ config, pkgs, lib, username, stateVersion, ... }:

{
  # More informations and options in
  # https://nix-community.github.io/home-manager/options.xhtml
  
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "${stateVersion}";
  };

  # Home Manager manage itself
  programs.home-manager.enable = true;
}
