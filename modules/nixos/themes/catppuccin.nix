{ inputs, ... }:
{
  imports = [ inputs.catppuccin.nixosModules.catppuccin ];

  catppuccin = {
    enable = true;
    flavor = "macchiato";

    tty.enable = true;
  };
}
