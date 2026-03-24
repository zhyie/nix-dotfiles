{ inputs, ... }:
{
  environment.variables.NEWT_COLORS = builtins.readFile (inputs.dotfiles + "/nmtui/palette");
}
