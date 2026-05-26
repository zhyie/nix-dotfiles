{ lib, hostConfig, ... }:
{
  users.users = lib.genAttrs hostConfig.users (user: {
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
