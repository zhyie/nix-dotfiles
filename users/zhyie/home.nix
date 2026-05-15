{ home, pkgs, ... }:
{
  imports = [
    home.programs.default
    home.programs.games
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
    "nushell/config.nu"
  ];
  dotfiles.homeFiles = [
    ".nanorc"
  ];
  # xdg.configFile."nushell/config.nu".source = {};
}
