{ inputs, ... }:
{
  users.users.zhyie = {
    extraGroups = [
      "gamemode"
      "lpadmin"
    ];

    openssh.authorizedKeys.keyFiles = [
      (inputs.secrets + "/zhyie/id_ed25519.pub")
      (inputs.secrets + "/zhyie/zhyie_elitenix.pub")
    ];
  };
}
