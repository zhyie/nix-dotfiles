{ inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFormat = "yaml";
    defaultSopsFile = inputs.secrets + "/secrets.yaml";
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    age.keyFile = "~/.config/sops/age/keys.txt";

    # secrets = {
    #   "networks/home/wifi_1/ssid" = { };
    #   "networks/home/wifi_2/psk" = { };
    #   # "duckdns/token" = { };
    # };
  };
}
