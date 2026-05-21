rec {
  display-managers = import ./display-managers;
  inherit (display-managers) lemurs lightdm ly;

  #: Misc
  duckdns = import ./duckdns;
  flatpak = import ./flatpak;

  #: Networking
  avahi = import ./avahi.nix;
  dnscrypt = import ./dnscrypt.nix;
  ssh = import ./ssh.nix;
}
