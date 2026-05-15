{
  utils = import ./utils;
  dev = import ./dev;
  common = import ./common;

  # PROGRAMS
  programs = {
    default = import ./programs;
    bash = import ./programs/bash.nix;
    direnv = import ./programs/direnv.nix;
    feh = import ./programs/feh.nix;
    git = import ./programs/git.nix;
    kitty = import ./programs/kitty.nix;
    neovim = import ./programs/neovim.nix;
    qimgv = import ./programs/qimgv.nix;
    rofi = import ./programs/rofi.nix;
    yazi = import ./programs/yazi.nix;

    flatpak = import ./programs/flatpak;
    games = import ./programs/games;
  };

  # SERVICES
  services = {
    default = import ./services;
    dunst = import ./services/dunst.nix;
  };

  # THEMES
  themes = {
    default = import ./themes;
  };
}
