{ lib, userList, ... }:

{
  users.users = lib.genAttrs userList (user: {
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
