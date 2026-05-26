{ inputs, lib, ... }:

let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in
{
  #: Nix configuration.
  nix = {
    #: Enable experimental features such as flakes
    #: and other settings for nix.
    extraOptions = ''
      experimental-features = nix-command flakes

      auto-optimise-store = true
      flake-registry = ""
      keep-outputs = true
      use-xdg-base-directories = true;
    '';

    #: Flake registries.
    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;

    #: Nix expression search path.
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

    #: URLs and public keys of binary caches.
    substituters = [ "https://nix-community.cachix.org" ];
    trustedPublicKeys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
  };

  #: Nixpkgs configuraiton.
  nixpkgs = {
    #: Allow unfree packages.
    config.allowUnfree = true;

    #: Overlays to apply to Nixpkgs.
    overlays = lib.attrValues inputs.self.overlays;
  };
}
