{
  elitenix = {
    module = [ ./elitenix ];
    users = [ "zhyie" ];
    platform = "nixos";
    system = "x86_64-linux";
    stateVersion = "25.11";
    withHome = true;
  };

  redroid = {
    module = [ ./redroid ];
    users = [ "cherry" ];
    platform = "droid";
    system = "aarch64-linux";
    stateVersion = "24.05";
    withHome = false;
  };

  asunix = {
    module = [ ./asunix ];
    users = [ "absky" ];
    platform = "nixos";
    system = "x86_64-linux";
    stateVersion = "25.11";
    withHome = false;
  };
}
