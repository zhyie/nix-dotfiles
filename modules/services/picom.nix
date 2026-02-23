{ pkgs, ... }:

{
  home.file.".config/picom" = {
    source = ../../config/picom;
  };

  environment.systemPackages = with pkgs; [ picom ];

  services.picom = {
    enable = true;
  };
}
