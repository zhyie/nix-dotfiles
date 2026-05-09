{
  imports = [ ./flatpak.nix ];

  services.flatpak = {
    packages = [ "io.mrarm.mcpelauncher" ];
  };
}
