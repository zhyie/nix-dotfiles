{ config, inputs, ... }:
{
  users.users.zhyie = {
    extraGroups = [ "gamemode" ];

    openssh.authorizedKeys.keyFiles = [
      (inputs.secrets + "/keys/zhyie/id_ed25519.pub")
      (inputs.secrets + "/keys/zhyie/zhyie_elitenix.pub")
    ];
  };

  # home-manager.users.zhyie = {
  #   modules.xserver.enable = config.modules.gui.x11.enable;
  #   modules.wayland.enable = config.modules.gui.wayland.enable;
  # };
}
