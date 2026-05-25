{
  default = import ./display-managers.nix;

  lemurs = import ./lemurs.nix;
  lightdm = import ./lightdm.nix;
  ly = import ./ly.nix;
}
