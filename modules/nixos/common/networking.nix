{ config, hostName, ... }:
{
  networking = {
    inherit hostName;
    networkmanager = {
      enable = true;
      dns = "none";
      wifi.powersave = true;

      # ensureProfiles = {
      #   profiles = {
      #     HOME_WIFI = {
      #       connection = {
      #         id = "PLDTFIBR";
      #         type = "wifi";
      #       };
      #       wifi = {
      #         mode = "infrastructure";
      #         ssid = config.sops.secrets."networks/home_wifi/ssid".path;
      #       };
      #       wifi-security = {
      #         auth-alg = "open";
      #         key-mgmt = "wpa-psk";
      #         psk = config.sops.secrets."networks/home_wifi/psk".path;
      #       };
      #       ipv4 = {
      #         method = "auto";
      #       };
      #       ipv6 = {
      #         method = "auto";
      #         # addr-gen-mode = "stable-privacy";
      #       };
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
