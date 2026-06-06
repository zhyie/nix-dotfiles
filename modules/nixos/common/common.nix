{
  # config,
  inputs,
  lib,
  nixos,
  ...
}:
{
  imports = [
    nixos.security.ssh
  ];

  /**
    Set pre-configured nanorc with lib.mkDefault,
    so hosts can override the nano configuration.
  */
  programs.nano.nanorc = lib.mkDefault (lib.readFile "${inputs.dotfiles}/.nanorc");
}
