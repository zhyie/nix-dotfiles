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

    picom = prev.picom.overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [
        (prev.fetchpatch {
          url = "https://github.com/yshui/picom/commit/676196359c15bb654696b05700330685db914710.patch";
          hash = "sha256-YbpGL6FvXdIh3N5zJ1oJJc/YOLLVQL0Jlp0LetpnecA=";
        })
      ];
    });
  };
}
