{ pkgs, inputs }:
{
  hm = inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default;

  git-hooks = pkgs.callPackage ./git-hooks.nix { inherit inputs; };
  scripts = pkgs.callPackage ./scripts.nix { inherit inputs; };
}
