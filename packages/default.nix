{ pkgs, inputs, ... }:
{
  scripts = pkgs.callPackages ./scripts.nix { inherit inputs; };
}
