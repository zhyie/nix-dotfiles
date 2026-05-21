{ ... }:
{
  imports = [ ./catppuccin.nix ];

  catppuccin.tty = {
    enable = true;
    flavor = "mocha";
  };
}
