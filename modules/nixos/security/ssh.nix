{
  config,
  nixos,
  hostConfig,
  ...
}:
{
  imports = [ nixos.security.fail2ban ];

  services.openssh = {
    enable = true;
    ports = [ 8022 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = hostConfig.users;
    };
  };

  programs.ssh.startAgent = config.services.openssh.enable;
}
