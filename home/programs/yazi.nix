{ dots, ... }:



{
  xdg.configFile = dots.configFile "yazi";

  programs.yazi = {
    enable = true;
  };
}
