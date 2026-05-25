{
  config,
  lib,
  inputs,
  ...
}:
{
  services.flameshot = {
    enable = lib.mkDefault true;
  };

  xdg.configFile.flameshot = lib.mkIf config.services.flameshot.enable {
    source = inputs.dotfiles + "/flameshot";
  };
}
