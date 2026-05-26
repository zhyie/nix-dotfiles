{
  inputs,
  lib,
  nixos,
  ...
}:
{
  imports = [
    inputs.self.modules.common.modules
    inputs.self.modules.common.variables

    nixos.services.ssh
  ];

  /**
    Set pre-configured nanorc with lib.mkDefault,
    so hosts can override the nano configuration.
  */
  programs.nano.nanorc = lib.mkDefault (lib.readFile "${inputs.dotfiles}/.nanorc");
}
