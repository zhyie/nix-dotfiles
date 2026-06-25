{
  lib,
  inputs,
  nixos,
  hostConfig,
  ...
}:

let
  inherit (lib) elem optionals;
in
{
  imports = [
    nixos.common
    nixos.security.sops
    nixos.security.ssh
    nixos.security.fail2ban
  ]
  ++ optionals (elem "zhyie" hostConfig.users) [ nixos.security.sudo ]
  #
  ;

  services = {
    openssh.enable = true;
    fail2ban.enable = true;
  };

  /**
    Set pre-configured nanorc with lib.mkDefault,
    so hosts can override the nano configuration.
  */
  programs.nano.nanorc = lib.mkDefault (lib.readFile "${inputs.dotfiles}/.nanorc");
}
