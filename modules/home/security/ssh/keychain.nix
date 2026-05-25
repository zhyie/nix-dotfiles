{ config, ... }:
{
  programs.keychain = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = config.programs.nushell.enable;

    keys = [
      "id_ed25519"
    ];
  };
}
