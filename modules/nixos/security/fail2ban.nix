{ ... }:
{
  services.fail2ban = {
    maxretry = 5;
    bantime-increment = {
      enable = true;
    };
  };
}
