{ pkgs, inputs, ... }:
{
  users.users.zhyie = {
    extraGroups = [ "wheel" ];
    shell = pkgs.nushell;
    openssh.authorizedKeys.keyFiles = [
      (inputs.secrets + "/keys/zhyie/id_ed25519.pub")
      (inputs.secrets + "/keys/zhyie/zhyie_elitenix.pub")
    ];
  };
}
