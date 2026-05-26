{ home, pkgs, ... }:
{
  imports = [
    ./variables.nix
    ./osConfig.nix

    home.common
    home.dev
    home.themes

    home.profiles.graphical
    home.profiles.gaming
  ];

  modules = {
    dev.enable = true;

    flatpak = {
      enable = true;
      apps = {
        libreoffice.enable = true;
      };
    };
  };

  home.packages = builtins.attrValues {
    inherit (pkgs.custom) scripts;
    inherit (pkgs) discord;
  };

  dotfiles = {
    configFiles = [
      "nvim"
      "picom"
      "kitty"
      "rofi"
      "yazi"
      "btop"
      "nushell/config.nu"
      "niri"
    ];
    homeFiles = [
      ".nanorc"
    ];
  };
}
