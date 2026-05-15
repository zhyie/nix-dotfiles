{ hostName, hostConfig, ... }:

let
  inherit (hostConfig) userList;
  userHost = map (userName: userName + "@" + hostName) userList;
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks."*" = {
      addKeysToAgent = "yes";
      IdentityFile = [ "id_ed25519" ] ++ userHost;
      forwardAgent = false;
      compression = false;
      serverAliveInterval = 0;
      serverAliveCountMax = 3;
      hashKnownHosts = false;
      userKnownHostsFile = "~/.ssh/known_hosts";
      controlMaster = "no";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "no";
    };
  };
}
