{ inputs, ... }:

let
  inherit (inputs) catppuccin;

  catp = catppuccin.homeModules.catppuccin;
in

{
  zhyie = {
    default = import ./zhyie;
    home    = import ./zhyie/home.nix;
    hostList = [ "zhyie" "zhyie@elitenix" ];
    moduleList = [
      catp
    ];
  };

  # riri = {
  #   home = import ./riri/home.nix;
  #   hostList = [ "riri" ];
  #   moduleList = [];
  # };
  #
  # absky = {
  #   default = import ./absky;
  #   home    = import ./absky/home.nix;
  #   hostList = [ "absky" "absky@asunix" ];
  #   moduleList = [];
  # };
}
