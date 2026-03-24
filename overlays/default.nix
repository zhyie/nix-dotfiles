{ inputs, ... }:
{
  # Unstable nixpkgs
  unstable-packages = final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  # additions = final: _prev: import ../packages final.pkgs;
}
