{
  # HOME ENTRY
  default = import ./home.nix;
  # as nixos module
  nixos = import ./nixos.nix;
  # home utils
  utils = import ./utils;

  # PROGRAMS
  programs = {
    default = import ./programs;
    bash    = import ./programs/bash.nix;
    direnv  = import ./programs/direnv.nix;
    feh     = import ./programs/feh.nix;
    git     = import ./programs/git.nix;
    kitty   = import ./programs/kitty.nix;
    neovim  = import ./programs/neovim.nix;
    qimgv   = import ./programs/qimgv.nix;
    rofi    = import ./programs/rofi.nix;
    yazi    = import ./programs/yazi.nix;
  };

  # SERVICES
  services = {
    default = import ./services;
    dunst   = import ./services/dunst.nix;
  };

  # THEMES
  themes = {
    default = import ./themes;
  };
}
