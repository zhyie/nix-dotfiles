{ config, pkgs, ... }:
{
  programs.git = {
    # enable = config.modules.dev.enable;
    enable = true;
    package = if config.modules.dev.enable then pkgs.git else pkgs.gitMinimal;

    settings = {
      user = {
        name = config.variables.git.user;
        email = config.variables.git.email;
      };

      init.defaultBranch = "main";
    };
  };
}
