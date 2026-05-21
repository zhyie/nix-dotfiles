{ home, pkgs, ... }:
{
  imports = [
    home.common
    home.programs.default
    home.programs.games
    home.services.default
    home.themes.default
    home.dev
    ./variables.nix
    ./osConfig.nix
  ];

  modules = {
    dev.enable = true;
    flatpak = {
      enable = true;
      packages = [ "libreoffice" ];
    };
  };

  home.packages = builtins.attrValues {
    inherit (pkgs.unstable) discord;
    inherit (pkgs.custom) scripts;
  };

  dotfiles.configFiles = [
    "nvim"
    "picom"
    "kitty"
    "rofi"
    "yazi"
    "btop"
    "nushell/config.nu"
    "niri"
  ];
  dotfiles.homeFiles = [
    ".nanorc"
  ];
}
