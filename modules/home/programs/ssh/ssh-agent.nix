{ config, ... }:
{
  services.ssh-agent = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = config.programs.nushell.enable;
  };
}
