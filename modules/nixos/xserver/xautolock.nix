{ pkgs, ... }:

let
  inherit (pkgs) xlockmore libnotify systemd;
in
{
  environment.systemPackages = [
    xlockmore
    libnotify
  ];

  services.xserver.xautolock = {
    enable = true;
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
