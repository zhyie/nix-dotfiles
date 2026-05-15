{ ... }:
{
  imports = [ ./direnv-instant.nix ];

  programs = {
    direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };
  };
}
