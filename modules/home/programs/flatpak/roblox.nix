{
  imports = [ ./flatpak.nix ];

  services.flatpak = {
    packages = [ "org.vinegarhq.Sober" ];
  };
}
