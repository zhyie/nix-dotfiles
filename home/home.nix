# More informations and options in
# https://nix-community.github.io/home-manager

# { user, stateVersion, ... }:
{ user, ... }:

{
  # Information for the Home Manager
  home = {
    # User(s) for Home Manager
    username = "${user}";

    # The path Home Manager should manage.
    # Usually the $HOME path.
    homeDirectory = "/home/${user}";

    # Home Manager release that the configuration is compatible with.
    stateVersion = "25.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
