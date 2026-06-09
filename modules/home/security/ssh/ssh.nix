{ hostName, userName, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "${userName}" = {
        AddKeysToAgent = "yes";
        IdentityFile = [
          "id_ed25519"
          "${userName}_${hostName}"
        ];
        ForwardAgent = true;
        UserKnownHostsFile = "~/.ssh/known_hosts";
      };

      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/github";
        AddKeysToAgent = "yes";
      };
    };
  };
}
