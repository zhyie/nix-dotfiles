{ userList, ... }:
{
  services.openssh = {
    enable = true;
    ports = [ 7238 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = userList;
    };
  };

  programs.ssh.startAgent = true;
}
