{ inputs }:
{
  # Unstable nixpkgs
  unstable-packages = final: _: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) config;
      inherit (final.stdenv.hostPlatform) system;
    };
  };

  # Custom built packages
  custom-packages = final: _: {
    custom = inputs.self.packages.${final.stdenv.hostPlatform.system};
  };

  modify-packages = _: prev: {
    firefox = import ./firefox.nix { inherit inputs prev; };
    openldap = prev.openldap.overrideAttrs { doCheck = false; };
  };
}
