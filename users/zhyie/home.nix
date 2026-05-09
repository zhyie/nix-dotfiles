{ home, pkgs, ... }:
{
  imports = [
    home.programs.default
    home.services.default
    home.themes.default
    home.dev
    home.utils
  ];

  home.packages = builtins.attrValues {
    inherit (pkgs.unstable) discord;
    inherit (pkgs.custom) scripts;
  };

  home.file = {
    ".gitconfig".source = ./.gitconfig;
  };

  dotfiles.configFiles = [
    "nvim"
    "picom"
    "kitty"
    "rofi"
    "yazi"
    "btop"
  ];
  dotfiles.homeFiles = [
    ".nanorc"
  ];

  # vars.path = ".flake";
}
