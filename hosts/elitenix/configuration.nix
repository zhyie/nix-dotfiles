# Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, hostname, ... }:

{
  imports = [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./laptop-behavior.nix

      ./locale.nix
      #./modules/user.nix

      ../../modules/core
      ../../modules/hardware
      ../../modules/services

      ./environment.nix
      ./special-keymap.nix
    ];

  networking.hostName = "${hostname}";

  # Console settings.
  console = {
    font = "sun12x22";
    keyMap = "us";
    # useXkbConfig = true; # use xkb.options in tty.
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zhyie = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;


  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  ###############################
  #          OFF LIMIT          #
  #    SYSTEM STATE VERSION     #
  ###############################
  system.stateVersion = "25.11";
}
