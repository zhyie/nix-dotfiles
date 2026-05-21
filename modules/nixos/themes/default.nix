rec {
  catppuccin = import ./catppuccin;
  inherit (catppuccin) default console nmtui;
}
