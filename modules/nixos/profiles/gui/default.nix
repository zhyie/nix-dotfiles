{ lib, ... }:
{
  imports = [ ./gui.nix ];

  modules.gui = {
    x11.enable = lib.mkDefault true;
    login.manager = lib.mkDefault "ly";
  };
}
