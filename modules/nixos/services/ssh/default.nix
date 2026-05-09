{ hostConfig, ... }:
{
  services.openssh = {
    enable = true;
    ports = [ 7238 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = hostConfig.userList;
    };
  };

  programs.ssh.startAgent = true;
}
