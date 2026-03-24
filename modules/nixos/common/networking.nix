{ host, ... }:
{
  networking = {
    hostName = "${host}";
    networkmanager = {
      enable = true;
      dns = "none";
      wifi.powersave = true;
      # ensureProfiles = {
      #   home-wifi = {
      #     connection = {
      #       id = "home-wifi";
      #       type = "wifi";
      #     };
      #     wifi = {
      #       mode = "infrastructure";
      #       ssid = "";
      #     };
      #     wifi-security = {
      #       auth-alg = "open";
      #       key-mgmt = "wpa-psk";
      #       psk = "";
      #
      #     };
      #   };
      # };
    };
    nameservers = [
      "9.9.9.9"
      "1.1.1.1"
    ];
    firewall = {
      enable = true;
      allowedTCPPorts = [ 7238 ];
    };
  };
}
