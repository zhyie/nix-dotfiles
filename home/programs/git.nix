{ config, pkgs, ... }:

{

  programs.git = {
    enable = true;
    
    settings.user = {
      name = "zhyie";
      email = "128297362+zhyie@users.noreply.github.com";
      
      init.defaultBranch = "main";
    };

  };
}
