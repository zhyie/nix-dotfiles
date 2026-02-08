
# More informations and options in
# https://nix-community.github.io/home-manager/

{ config, pkgs, username, stateVersion, ... }:

{
  # The package are declared in separate nix file in home directory of this dotfiles
  # Import to install packages to include in home.
  import = [

    /* Examples:

    ./home/programs/kitty
    ./home/services/picom
    and so on ...
          
    */

  ];

  # Information for the Home Manager
  home = {

    # User of this Home Manager.
    username = "${username}";

    # The path Home Manager should manage.
    # Usually the $HOME path.
    homeDirectory = "/home/${username}";
    
    # The Home Manager release that the configuration is compatible with.
    # `stateVersion` defined in `../flake.nix`.
    stateVersion = "${stateVersion}";
    
    # inherit username stateVersion;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
