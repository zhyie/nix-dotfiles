{ inputs, ... }:
{
  # Unstable nixpkgs
  unstable-packages = final: _: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  # Custom built packages
  custom-packages = final: _: {
    custom = import ../packages {
      inherit inputs;
      pkgs = final;
    };
  };

  modify-packages = _: prev: {
    firefox = import ./firefox.nix {
      inherit inputs;
      pkgs = prev;
    };
  };

  suckless-packages = inputs.suckless.overlays.default;
}
