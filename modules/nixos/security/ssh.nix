{ inputs, ... }:
{
  services.openssh = {
    ports = [ 8022 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = builtins.attrNames (import "${inputs.self}/users");
    };
  };
}
