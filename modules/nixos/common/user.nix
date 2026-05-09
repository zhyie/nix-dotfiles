{ lib, hostConfig, ... }:
{
  users.users = lib.genAttrs hostConfig.userList (user: {
    description = "${user}";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
    ];
  });
}
