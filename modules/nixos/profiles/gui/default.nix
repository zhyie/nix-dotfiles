{ lib, ... }:
{
  imports = [ ./options.nix ];

  modules.gui = {
    xserver.enable = lib.mkDefault true;
  };
}
