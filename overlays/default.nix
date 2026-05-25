{ inputs }:
{
  #: Nixpkgs
  nix-packages =
    final: _:
    let
      importOverlay =
        p:
        import p {
          inherit (final) config;
          inherit (final.stdenv.hostPlatform) system;
        };
    in
    {
      unstable = importOverlay inputs.nixos-unstable;
      stable = importOverlay inputs.nixos-stable;
      # unstable = import inputs.nixpkgs-unstable {
      #   inherit (final) config;
      #   inherit (final.stdenv.hostPlatform) system;
      # };

      # stable = import inputs.nixpkgs-stable {
      #   inherit (final) config;
      #   inherit (final.stdenv.hostPlatform) system;
      # };
    };

  #: Custom built packages
  custom-packages = final: _: {
    custom = inputs.self.packages.${final.stdenv.hostPlatform.system};
  };

  modify-packages = _: prev: {
    firefox = import ./firefox.nix { inherit inputs prev; };
    openldap = prev.openldap.overrideAttrs { doCheck = false; };
  };

  droid = inputs.nix-on-droid.overlays.default;
}
