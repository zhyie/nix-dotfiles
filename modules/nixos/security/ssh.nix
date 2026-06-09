{ inputs, nixos, ... }:
{
  imports = [ nixos.security.fail2ban ];

  services.openssh = {
    enable = true;
    ports = [ 8022 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = builtins.attrNames (import "${inputs.self}/users");
    };
  };
}
