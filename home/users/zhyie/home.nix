{ config, pkgs, lib, username, ... }:

{
  # List of help at
  # https://nix-community.github.io/home-manager/options.xhtml

  # Home configurations.
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";

    # file.".config" = {
    #  source = ../../../config;
    #  recursive = true;
    # };
  };

  # Home Manager manage itself.
  programs.home-manager.enable = true;

  catppuccin.firefox = {
    enable = true;
    flavor = "macchiato";
    accent = "lavender";
  };

  # Import packages.
  imports = [

    ../../programs/bash.nix
    ../../programs/git.nix
    ../../programs/neovim.nix
    ../../programs/kitty.nix
    ../../programs/rofi.nix
    ../../programs/yazi.nix
    ../../programs/qimgv.nix
    ../../programs/feh.nix

    #../../../modules/picom.nix
    ../../services/dwm-status.nix
    #../../services/dwmblocks.nix

    # ../../modules/misc/fonts/fonts.nix
    ../../themes/fonts.nix
    ../../themes/cursors.nix
    ../../themes/icons.nix
  ];
}
