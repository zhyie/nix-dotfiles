{ pkgs, ... }:

{

  home.packages = with pkgs; [ dwm-status ];
  #environment.systemPackages = with pkgs; [ dwm-status ];

  services.dwm-status = {
    enable = true;
    #package = pkgs.dwm-status.overrideAttrs {
    #  src = ../../../config/dwm-status;
    #};

    #settings = {
      order = [ "battery" "time" ];
      #time = { 
	#format = "%A, %B %d, %Y %H:%M:%S";
	#update_seconds = false;
      #};
    #};
  };

  # home.file.".config/dwm-status" = {
  #   source = ../../.config/dwm-status;
  #   recursive = true;
  # }

}
