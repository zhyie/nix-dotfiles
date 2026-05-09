{ lib, pkgs, ... }:

let
  inherit (lib) getExe;
  picom = pkgs.unstable.picom;
in
{
  home.packages = [ picom ];

  systemd.user.services.picom = {
    Unit = {
      Description = "Picom X11 compositor";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${getExe picom}";
      Restart = "always";
      RestartSec = 3;
    };
  };
}
