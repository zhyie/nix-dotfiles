{ ... }:
{
  services.ssh-agent = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };
}
