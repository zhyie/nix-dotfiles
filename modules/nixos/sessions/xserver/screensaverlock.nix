{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (pkgs) xlockmore libnotify systemd;
  inherit (config.modules) xserver laptop;
in
{
  environment.systemPackages = lib.optionals (xserver.enable && laptop.enable) [
    xlockmore
  ];

  services.xscreensaver = {
    enable = xserver.enable && laptop.enable;
  };

  services.xserver.xautolock = {
    enable = xserver.enable && laptop.enable;
    time = 20;
    locker = "${xlockmore}/bin/xlock";
    nowlocker = "${xlockmore}/bin/xlock";

    enableNotifier = true;
    notify = 10;
    notifier = "${libnotify}/bin/notify-send 'Locking in 10 seconds'";

    killtime = 30;
    killer = "${systemd}/bin/systemctl suspend";

    extraOptions = [
      "-detectsleep"
      "-lockaftersleep"
      "-resetsaver"
    ];
  };
}
