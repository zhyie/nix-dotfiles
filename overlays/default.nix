{ inputs }:
{
  #: Nixpkgs
  nix-packages = final: _: {
    unstable = inputs.nixos-unstable.legacyPackages.${final.stdenv.hostPlatform.system};
    stable = inputs.nixos-stable.legacyPackages.${final.stdenv.hostPlatform.system};
    droid = inputs.nix-on-droid.overlays.default;
  };

  #: Custom built packages
  custom-packages = final: _: {
    custom = inputs.self.packages.${final.stdenv.hostPlatform.system};
  };

  modify-packages = _: prev: {
    firefox = import ./firefox.nix { inherit inputs prev; };
    openldap = prev.openldap.overrideAttrs { doCheck = false; };
  };
}
