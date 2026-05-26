#: More informations and options in
#: https://nix-community.github.io/home-manager

{ hostConfig, userName }:
{
  #: Information for the Home Manager
  home = {
    #: User for Home Manager
    username = userName;

    #: The path Home Manager should manage ($HOME path).
    homeDirectory = "/home/" + userName;

    #: Home Manager release that the configuration is compatible with.
    # stateVersion = "25.11";
    inherit (hostConfig) stateVersion;
  };

  #: Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
