{ config, lib, ... }:
{
  services.displayManager.lemurs = {
    enable = lib.mkIf (config.modules.graphical.display.manager == "lemurs") true;
  };
}
