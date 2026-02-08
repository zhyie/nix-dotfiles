{ config, lib, pkgs, ... }:

{

  users.users.zhyie = {
    description = "Zhyie, the baddest of all.";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
    ];
    packages = with pkgs; [
      tree
      
    ];
  }

  environment.sessionVariables = {


  };

}
