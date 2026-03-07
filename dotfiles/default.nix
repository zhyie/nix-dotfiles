{
  configFile = name: {
    "${name}" = {
      source = ./${name};
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
