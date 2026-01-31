{ config, lib, pkgs, ... }:

{

  services.xserver = {

    enable = true;
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs {
	src = ../../../config/dwm;
      };
    };
  };

  #environment.systemPackages = with pkgs; [ dwm-status ];
  #nixpkgs.overlays = [ (self: super: {
   # dwm = super.dwm.overrideAttrs (oldAttrs: {
    #  src = ../../../.config/dwm; }); }) ];

}
