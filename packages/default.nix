{ pkgs, inputs }:
{
  hm = inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default;

  treefmt = pkgs.callPackage ./treefmt.nix { inherit (inputs) self; };
  git-hooks = pkgs.callPackage ./git-hooks.nix { inherit (inputs.self) checks; };
  scripts = pkgs.callPackage ./scripts.nix { inherit inputs; };
}
