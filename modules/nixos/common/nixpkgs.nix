{ inputs, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = p: true;
    };
    overlays = builtins.attrValues inputs.self.overlays;
  };
}
