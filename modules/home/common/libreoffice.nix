{ pkgs, ... }:
{
  home.packages = [
    pkgs.libreoffice-fresh
    pkgs.hunspell
    pkgs.hunspellDicts.en_US
    pkgs.hyphenDicts.en_US
  ];
}
