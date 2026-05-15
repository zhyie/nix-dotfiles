{
  display-managers = import ./display-managers;
  flatpak = import ./flatpak;
  default = [
    ./avahi
    # ./dnscrypt
    ./ssh
  ];
}
