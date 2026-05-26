{ ... }:
{
  imports = [
    ./direnv.nix
    ./direnv-instant.nix
    ./git.nix
    ./neovim.nix
    ./hyfetch.nix
    # ./nushell
  ];

  modules.dev.enable = true;
}
