{ config, lib, pkgs, ... }:

{
  # Enable firefox.
  programs.firefox.enable = true;
  # Enable backlight.
  programs.light.enable = true;

  # Enable upower.
  services.upower.enable = true;

  environment.systemPackages = with pkgs; [
    # Nano editor is installed by default.
    wget
    neovim

    st
    dmenu
    pcmanfm
  ];
}
