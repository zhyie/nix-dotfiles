{
  #: Misc
  flatpak = import ./flatpak.nix;

  #: Networking
  avahi = import ./avahi.nix;
  dnscrypt = import ./dnscrypt.nix;
  duckdns = import ./duckdns.nix;
  ssh = import ./ssh.nix;
}
