{ lib, ... }:
{
  imports = [ ./gaming.nix ];

  modules.gaming = {
    env = "home";

    games =
      let
        inherit (lib) mkDefault;
      in
      {
        proton.enable = mkDefault true;
        heroic.enable = mkDefault true;
        faugus.enable = mkDefault true;
        roblox.enable = mkDefault true;
        mcpe.enable = mkDefault true;
      };
  };
}
