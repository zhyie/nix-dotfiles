{ home, pkgs, ... }:
{
  imports = [
    home.themes
    home.profiles.dev
    home.profiles.graphical
    home.profiles.gaming
  ];

  modules = {
    dev.enable = true;

    flatpak.apps = {
      libreoffice.enable = true;
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

  variables = {
    user.name = "zhyie";
    git.email = "128297362+zhyie@users.noreply.github.com";
  };
}
