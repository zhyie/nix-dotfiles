{ self, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = p: true;
    };
    overlays = [
      self.overlays.unstable-packages
    ];
  };
}
