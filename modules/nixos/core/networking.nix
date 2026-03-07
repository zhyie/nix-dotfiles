{ host, ... }:

{
  networking = {
    hostName = "${host}";
    networkmanager = {
      enable = true;
      dns = "none";
    };
    nameservers = [ "9.9.9.9" "1.1.1.1" ];
    firewall = {
      enable = true;
    };
  };
}
