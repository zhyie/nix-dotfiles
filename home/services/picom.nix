{ config, lib, pkgs, dots, ... }:

# let
#   inherit (lib) getExe;
# in
{
  services.picom = {
    enable = true;
    package = pkgs.unstable.picom;
  };

#   home.packages = [ pkgs.unstable.picom ];

  # systemd.user.services.picom = {
  #   Unit = {
  #     Description = "Picom X11 compositor";
  #     After = [ "graphical-session.target" ];
  #     PartOf = [ "graphical-session.target" ];
  #   };
  #
  #   Install = {
  #     WantedBy = [ "graphical-session.target" ];
  #   };
  #
  #   Service = {
  #     ExecStart = "${getExe pkgs.picom} --config ${dots.picom}/picom.conf";
  #     Restart = "always";
  #     RestartSec = 3;
  #   };
  # };
}
