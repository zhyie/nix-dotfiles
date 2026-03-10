{ config, ... }:

let
  outLink = config.lib.file.mkOutOfStoreSymlink;
in

{
  configFile = name: {
    "${name}" = {
      source = outLink ./${name};
      recursive = true;
    };
  };

  dunst   = ./dunst;
	feh     = ./feh;
	kitty   = ./kitty;
	nvim    = ./nvim;
	picom   = ./picom;
	rofi    = ./rofi;
  yazi    = ./yazi;
}
