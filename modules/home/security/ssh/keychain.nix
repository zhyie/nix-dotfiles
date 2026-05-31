{
  config,
  hostName,
  userName,
  ...
}:
{
  programs.keychain = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableNushellIntegration = config.programs.nushell.enable;

    keys = [
      "${userName}_${hostName}"
      "id_ed25519"
      "github"
    ];
  };
}
