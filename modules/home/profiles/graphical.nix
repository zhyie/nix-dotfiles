{ inputs, home, ... }:
{
  imports = [
    #: Programs
    home.programs.btop
    home.programs.feh
    home.programs.firefox
    home.programs.medias
    home.programs.rofi
    home.programs.yazi

    #: Services
    home.services.dunst
    home.services.flameshot
    home.services.picom
    home.services.udiskie

    #: Themes
    home.themes

    #: Security
    home.security.ssh

    #: FLatpaks
    inputs.self.modules.common.flatpak
    home.programs.flatpak
  ];
}
