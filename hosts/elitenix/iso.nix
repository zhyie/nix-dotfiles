{ modulesPath, ... }:
{
  imports = [
    #: ISO Image
    (modulesPath + "/installer/cd-dvd/iso-image.nix")
  ];

  isoImage = {
    makeEfiBootable = true;
    makeUsbBootable = true;
  };
}
