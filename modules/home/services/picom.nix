{ lib, pkgs, ... }:
{
  home.packages = [ pkgs.picom ];

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
      ExecStart = "${lib.getExe pkgs.picom}";
      Restart = "always";
      RestartSec = 3;
    };
  };
}
