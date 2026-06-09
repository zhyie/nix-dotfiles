{ ... }:
{
  imports = [
    ./direnv.nix
    ./direnv-instant.nix
    ./neovim.nix
    ./hyfetch.nix
    # ./nushell
  ];

  modules.dev.enable = true;
}
