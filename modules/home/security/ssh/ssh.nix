{ hostName, userName, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "${userName}" = {
        addKeysToAgent = "yes";
        identityFile = [
          "id_ed25519"
          "${userName}_${hostName}"
        ];
        forwardAgent = true;
        userKnownHostsFile = "~/.ssh/known_hosts";
      };

      "github.com" = {
        addKeysToAgent = "yes";
        identityFile = [ "github" ];
        forwardAgent = true;
        userKnownHostsFile = "~/.ssh/known_hosts";
      };
    };
  };
}
