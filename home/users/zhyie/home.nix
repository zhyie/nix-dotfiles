{ config, pkgs, lib, username, ... }:

{
  # List of options in
  # https://nix-community.github.io/home-manager/options.xhtml

  # Home configurations.
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";
  };

  # Home Manager manage itself.
  programs.home-manager.enable = true;

  catppuccin.yazi = {
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

    ../../themes/fonts.nix
    ../../themes/icons.nix
    ../../themes/catppuccin.nix
  ];
}
