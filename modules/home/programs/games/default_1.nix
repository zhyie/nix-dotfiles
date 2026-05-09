{ inputs, home, ... }:
let
  inherit (home.programs) flatpak;
  inherit (inputs.self.modules) gaming;
in
{
  imports = [
    flatpak
    gaming
  ];

  modules.gaming.flatpak = flatpak;
}
