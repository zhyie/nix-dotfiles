{
  elitenix = {
    module = [ ./elitenix ];
    users = [ "zhyie" ];
    profiles = [
      "laptop"
      "graphical"
      "gaming"
    ];
    platform = "nixos";
    system = "x86_64-linux";
    stateVersion = "25.11";
    withHome = true;
  };

  redroid = {
    module = [ ./redroid ];
    users = [ "cherry" ];
    profiles = [ ];
    platform = "droid";
    system = "aarch64-linux";
    stateVersion = "24.05";
    withHome = false;
  };
}
