{
  modules = import ./modules.nix;
  variables = import ./variables.nix;
  gaming = import ./gaming;
  flatpak = import ./flatpak;
}
