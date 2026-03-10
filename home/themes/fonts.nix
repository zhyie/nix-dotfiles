{config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-mono
    liberation_ttf
    inter
    eb-garamond
    crimson
  ];

  fonts.fontconfig = {
    enable = true;
    antialiasing = true;
    hinting = "slight";
    subpixelRendering = "rgb";
    defaultFonts = {
      monospace = [
        "JetBrainsMono Nerd Font Mono"
        "FiraCode Nerd Font Mono"
      ];
      sansSerif = [
        "Inter"
        "Liberation Sans"
      ];
      serif = [
        "EB Garamond Initials"
      ];
    };
  };
}
