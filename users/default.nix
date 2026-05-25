{
  zhyie = {
    default = import ./zhyie;
    home = import ./zhyie/home.nix;
    profiles = [
      "dev"
      "gaming"
    ];
  };

  cherry = {
    default = import ./cherry;
    home = import ./cherry/home.nix;
    profileList = [ "dev" ];
  };
}
