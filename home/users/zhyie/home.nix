{ config, pkgs, lib, username, ... }:

{
  # List of help at 
  # https://nix-community.github.io/home-manager/options.xhtml
  
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";
  };

  # Home Manager manage itself
  programs.home-manager.enable = true;


  # Import packages.
  imports = [

    ../../programs/git.nix
    ../../programs/neovim.nix
    ../../programs/kitty.nix
    ../../programs/rofi.nix
    ../../programs/yazi.nix

    ../../services/picom.nix

    # ../../modules/misc/fonts/fonts.nix
    ../../fonts/fonts.nix

  ];
}
