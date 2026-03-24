{ home, ... }:
{
  home.file = {
    ".gitconfig".source = ./.gitconfig;
  };

  dotfiles.configFiles = [
    "picom"
    "kitty"
    "rofi"
    "yazi"
    "btop"
  ];

  # vars = {
  #   flake = ".os";
  #   user = {
  #     name = "zhyie";
  #     email = "zhyie";
  #   };
  # };

  imports = [
    home.programs.default
    home.services.default
    home.themes.default
    home.dev
    home.utils
  ];
  # home.packages = builtins.attrValues {
  # };
}
