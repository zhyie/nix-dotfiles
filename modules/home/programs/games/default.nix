{ inputs, home, ... }:
{
  imports = [ inputs.self.modules.gaming ];

  modules.gaming.flatpak = home.programs.flatpak;
}
