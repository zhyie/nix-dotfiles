{ name, recursive ? true, ... }:

{
  "${name}" = {
    source = ./${name};
    recursive = recursive;
  };



  dunst   = ./dunst;
	feh     = ./feh;
	kitty   = ./kitty;
	nvim    = ./nvim;
	picom   = ./picom;
	rofi    = ./rofi;
  yazi    = ./yazi;

}
