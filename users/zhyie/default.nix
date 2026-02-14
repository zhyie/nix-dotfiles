{ config, lib, pkgs, username, ... }:

{
  users.users.${username} = {
    description = "${username}, the baddest of all.";
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
