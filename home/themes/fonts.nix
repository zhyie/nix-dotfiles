{config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.caskaydia-cove
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font Mono" ];
        sansSerif = [ "JetBrainsMono Nerd Font" ];
        serif = [ "CaskaydiaCove Nerd Font" ];
    };
  };
}
