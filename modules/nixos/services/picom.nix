{ pkgs, ... }:

{
  environment.etc."picom/picom.conf" = {
    source = ../../../dotfiles/picom/picom.conf;
  };

  #environment.systemPackages = builtins.attrValues { inherit (pkgs) picom; };

  services.picom = {
    enable = true;
    package = pkgs.picom;
  };
}
