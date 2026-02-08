{ pkgs, ... }:

{
  #-------------------------------------------------
  # Package repository and configuration options: 
  # https://github.com/Gerschtli/dwm-status
  #-------------------------------------------------
  # Nixpkgs package:
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/dw/dwm-status/package.nix
  #-------------------------------------------------
  # Nixpkgs module:
  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/misc/dwm-status.nix
  #-------------------------------------------------
  # Home Manager module
  # https://github.com/nix-community/home-manager/blob/master/modules/services/dwm-status.nix
  #-------------------------------------------------
  
  home.packages = with pkgs; [ 
    dwm-status
    
    # The following are dependencies:
    alsa-utils
    dig
    wirelesstools
  ];

  # Configure in nix-way or import json config file
  services.dwm-status = {
    enable = true;
    # order = [ "battery" "time" ];
    extraConfig = builtins.fromJSON (builtins.readFile ./dwm-status/dwm-status.json);
  };

}
