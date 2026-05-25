{ pkgs, ... }:
{
  services.displayManager.ly = {
    enable = true;

    settings = {
      brightness_down_cmd = "${pkgs.light}/bin/light -U 10";
      brightness_up_cmd = "${pkgs.light}/bin/light -A 10";
      battery_id = "BAT0";
      show_tty = true;

      auth_fails = 5;
      clear_password = true;
      default_input = "password";

      bigclock = "en";
      bigclock_seconds = true;
      clock = "%a, %b %d %H:%M:%S";
    };
  };
}
